# takelage bit scope module
module BitScopeModule

  # Backend method for bit scope add.
  def bit_scope_add(scope)
    log.debug "Adding bit remote scope \"#{scope}\" to local workspace"

    return false unless configured? %w(bit_ssh bit_remote)

    unless bit_check_workspace
      log.error 'No bit workspace'
      return false
    end

    if git_check_workspace
      unless git_check_master
        log.error 'Not on git master branch'
        return false
      end
    end

    # check if bit remote scope exists
    scope_list = bit_scope_list
    log.debug scope_list
    unless scope_list.include? scope
      log.error "The bit remote bit scope \"#{scope}\" doesn't exist"
      return false
    end

    # get bit remote from active config
    bit_remote =
        config.active['bit_remote']

    # prepare scope add command
    cmd_bit_scope_add = "bit remote add #{bit_remote}/#{scope}"
    run cmd_bit_scope_add

    log.info "Added bit remote scope \"#{scope}\" to local bit workspace"
  end

  # Backend method for bit scope inbit.
  def bit_scope_inbit
    log.debug "Logging in to bit remote server"

    return false unless configured? %w(bit_ssh)

    cmd_bit_scope_login =
        config.active['bit_ssh']

    run_and_exit cmd_bit_scope_login
  end

  # Backend method for bit scope list.
  # @return [String] list of bit scopes
  def bit_scope_list
    log.debug "Listing bit remote scopes"

    return false unless configured? %w(bit_ssh bit_remote)

    # get ssh command from active config
    cmd_bit_ssh =
        config.active['bit_ssh']

    # prepare scope list command
    root =
        config.active['bit_root']

    cmd_bit_scope_list =
        config.active['cmd_bit_scope_list_find_scopes'] % {
            root: root
        }

    # run ssh command with scope list command
    scope_list = run "#{cmd_bit_ssh} '#{cmd_bit_scope_list}'"

    # remove bit remote root directory from results
    scope_list.gsub!(/#{root}\/*/, '')

    # remove /scope.json from results
    scope_list.gsub!(/\/scope.json/, '')

    scope_list
  end

  # Backend method for bit scope new.
  # @return [Int] status of new command
  def bit_scope_new(scope)
    log.debug "Creating new bit remote scope \"#{scope}\""

    return false unless configured? %w(bit_ssh bit_remote)

    # check if bit remote scope already exists
    scope_list = bit_scope_list
    if scope_list.include? scope
      log.error "The remote bit scope \"#{scope}\" already exists"
      return false
    end

    # get ssh command from active config
    cmd_bit_ssh =
        config.active['bit_ssh']

    # prepare scope list command
    root =
        config.active['bit_root']

    cmd_bit_scope_new =
        config.active['cmd_bit_scope_new_bit_init'] % {
            scope: scope, root: root
        }

    # run ssh command with scope new command
    run "#{cmd_bit_ssh} '#{cmd_bit_scope_new}'"

    log.info "Created new bit remote scope \"#{scope}\""
  end
end
