# takelage bit scope module
module BitScopeModule

  # Backend method for bit scope add.
  def bit_scope_add(scope)
    log.debug "Adding bit remote scope \"#{scope}\" to local workspace"

    if git_check_workspace
      unless git_check_master
        log.error 'Not on git master branch'
        return
      end
    end

    # check if bit remote scope exists
    scope_list = bit_scope_list
    log.debug scope_list
    unless scope_list.include? scope
      log.error "The bit remote bit scope \"#{scope}\" doesn't exist"
      exit false
    end

    # get bit remote from active config
    bit_remote = config.active['bit_remote']

    # prepare scope add command
    cmd_bit_scope_add = "bit remote add #{bit_remote}/#{scope}"
    run cmd_bit_scope_add

    log.info "Added bit remote scope \"#{scope}\" to local bit workspace"
  end

  # Backend method for bit scope list.
  # @return [String] list of bit scopes
  def bit_scope_list
    log.debug "Listing bit remote scopes"

    # get ssh command from active config
    cmd_bit_ssh = config.active['bit_ssh']

    # prepare scope list command
    root = config.active['bit_scope_root']
    cmd_bit_scope_list = config.active['bit_scope_list'] % {root: root}

    # run ssh command with scope list command
    scope_list, stderr, status = run_and_check "#{cmd_bit_ssh} '#{cmd_bit_scope_list}'"

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

    # check if bit remote scope already exists
    scope_list = bit_scope_list
    if scope_list.include? scope
      log.error "The remote bit scope \"#{scope}\" already exists"
      exit false
    end

    # get ssh command from active config
    cmd_bit_ssh = config.active['bit_ssh']

    # prepare scope list command
    root = config.active['bit_scope_root']
    cmd_bit_scope_new = config.active['bit_scope_new'] % {scope: scope, root: root}

    # run ssh command with scope new command
    run "#{cmd_bit_ssh} '#{cmd_bit_scope_new}'"

    log.info "Created new bit remote scope \"#{scope}\""
  end
end
