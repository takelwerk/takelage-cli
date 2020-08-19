# frozen_string_literal: true

# takelage bit require import
module BitRequireImport
  # Backend method for bit require import.
  def bit_require_import
    log.debug 'Running bit require import'

    return false unless _bit_clipboard_lib_prepare_workspace

    return false unless _bit_require_lib_check_require_file

    scopes = _bit_require_import_get_scopes_and_components
    return false unless scopes

    components = _bit_require_import_get_components scopes
    return false unless components

    return false unless _bit_require_import_add_scopes scopes

    _bit_require_import_paste_components components
  end

  private

  # Get scopes and components from requirements file.
  def _bit_require_import_get_scopes_and_components
    bit_require = read_yaml_file(@bit_require_file)
    return bit_require['scopes'] if bit_require.has_key? 'scopes'

    log.error "No scopes in #{@bit_require_file} file"
    false
  end

  # Get flat components array
  def _bit_require_import_get_components(scopes)
    components_all = []
    scopes.each do |scope, components|
      scope_components = _bit_require_import_get_scope_components scope, components
      return false unless scope_components

      components_all |= scope_components
    end
    components_all
  end

  # Get bit components of a scope.
  def _bit_require_import_get_scope_components(scope, components)
    scope_components = []
    components.each do |component|
      unless component.has_key? 'name'
        log.error "No component in #{scope_name}"
        return false
      end

      name = component['name']
      path = name
      path = component['path'] if component.has_key? 'path'

      log.debug "Identified bit component \"#{name}\" with path \"#{path}\" in scope \"#{scope}\""
      scope_components << {name: name, path: path, scope: scope}
    end
    scope_components
  end

  # Add bit scopes to workspace
  def _bit_require_import_add_scopes(scopes)
    scopes.each do |scope, components|
      log.debug "scope"
      log.debug scope
      bit_scope_add scope unless _bit_clipboard_bit_dev_scope_exists scope
    end
  end

  # Pasting bit components
  def _bit_require_import_paste_components(components)
    _rakefile, path = Rake.application.find_rakefile_location
    components.each do |component|
      cid = component[:name]
      dir = component[:path]
      pasted = bit_clipboard_paste cid, dir
      return false unless pasted

      dest = "#{path}/#{dir}"
      message = "Adding bit component \"#{cid}\" to path \"#{dest}\""
      _bit_clipboard_lib_git_add dest
      _bit_clipboard_lib_git_commit message
    end
    true
  end
end



