# frozen_string_literal: true

# takeltau bit require import
module BitRequireImport
  # Backend method for bit require import.
  def bit_require_import
    log.debug 'Running bit require import'

    return false unless configured? %w[project_root_dir]

    return false unless _bit_clipboard_lib_prepare_workspace

    return false unless _bit_require_import_check_require_file_exists

    scopes = _bit_require_import_get_scopes_and_components
    return false unless scopes

    components = _bit_require_import_get_components scopes
    return false unless components

    return false unless _bit_require_import_add_scopes scopes

    _bit_require_import_paste_components components
  end

  private

  # Check if a bit requirements file exists.
  def _bit_require_import_check_require_file_exists
    return true if File.exist? @bit_require_file

    log.error "No #{@bit_require_file} file found"
    false
  end

  # Get scopes and components from requirements file.
  def _bit_require_import_get_scopes_and_components
    bit_require = read_yaml_file(@bit_require_file)
    return bit_require['scopes'] if bit_require.key?('scopes')

    log.error "No scopes in #{@bit_require_file} file"
    false
  end

  # Get flat components array.
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
      return false unless _bit_require_import_check_component_valid component, scope

      name = component['name']
      path = name
      path = component['path'] if component.key?('path')
      scope_components << { name: name, path: path, scope: scope }
      log.debug "Identified bit component \"#{name}\" with path \"#{path}\" in scope \"#{scope}\""
    end
    scope_components
  end

  # Check if there are bit components
  def _bit_require_import_check_component_valid(component, scope)
    return true if component.instance_of?(Hash) && component.key?('name')

    log.error "No component in #{scope}"
    false
  end

  # Add bit scopes to workspace.
  def _bit_require_import_add_scopes(scopes)
    scopes.each do |scope, _components|
      bit_scope_add scope unless _bit_clipboard_bit_dev_scope_exists scope
    end
  end

  # Paste bit components.
  def _bit_require_import_paste_components(components)
    path = config.active['project_root_dir']
    return false if path.empty?

    components.each do |component|
      next if _bit_require_import_check_component_exists component, path

      return false unless _bit_require_import_paste_component component

      _bit_require_import_commit_component component, path
    end
    true
  end

  # Check if there are bit components
  def _bit_require_import_check_component_exists(component, path)
    scope = component[:scope]
    cid = component[:name]
    dir = component[:path]
    dest = "#{path}/#{dir}"
    cids = _bit_require_lib_get_components_ids
    return false unless cids.include? "#{scope}/#{cid}"

    log.warn "Skipping existing bit component \"#{scope}/#{cid}\" with path \"#{dest}\""
    true
  end

  # Paste a bit component
  def _bit_require_import_paste_component(component)
    scope = component[:scope]
    cid = component[:name]
    dir = component[:path]
    bit_clipboard_paste "#{scope}/#{cid}", dir
  end

  # Commit a bit component
  def _bit_require_import_commit_component(component, path)
    scope = component[:scope]
    cid = component[:name]
    dir = component[:path]
    dest = "#{path}/#{dir}"
    message = "Add bit component \"#{scope}/#{cid}\" to path \"#{dest}\""
    _bit_clipboard_lib_git_add dest
    _bit_clipboard_lib_git_commit message
  end
end
