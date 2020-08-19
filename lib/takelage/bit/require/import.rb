# frozen_string_literal: true

# takelage bit require import
module BitRequireImport
  # Backend method for bit require import.
  def bit_require_import
    log.debug 'Running bit require import'

    return false unless _bit_clipboard_lib_prepare_workspace

    return false unless _bit_require_lib_check_require_file

    scopes = _bit_require_import_get_scopes
    return false unless scopes

    components = []


    scopes.each do |scope|
      scope_components = _bit_require_import_get_scope_components(scope)
      return false unless scope_components

      components |= scope_components
    end

    log.debug "List of bit components: #{components.inspect}"

    components.each do |component|
      command_past = "tau past #{component[:scope]}/#{component[:name]} " \
                     "#{component[:path]}"
      command_git = "git add #{component[:path]} && " \
                    "git commit -m 'Add bit component " \
                    "#{component[:scope]}/#{component[:name]} local " \
                    "to #{component[:path]}'"
      log.debug "Bit command #{command_past}"
      log.debug "Git command #{command_git}"
    end
    true
  end

  private

  # Get all scopes from requirements file.
  def _bit_require_import_get_scopes
    bit_require = read_yaml_file(@bit_require_file)
    return bit_require['scopes'] if bit_require.has_key? 'scopes'

    log.error "No scopes in #{@bit_require_file} file"
    false
  end

  # Get bit components of a scope.
  def _bit_require_import_get_scope_components(scope)
    components = []
    scope.each do |scope_name, component_list|
      component_list.each do |component|
        unless component.has_key? 'name'
          log.error "No component in #{scope_name}"
          return false
        end

        name = component['name']
        path = name
        path = component['path'] if component.has_key? 'path'

        log.debug "Add bit component with name: '#{name}' and path: '#{path}'"
        components << {name: name, path: path, scope: scope_name}
      end
    end
    components
  end
end



