# frozen_string_literal: true

# takelage bit scope module
module BitScopeModule
  # Backend method for bit scope add.
  def bit_scope_add(scope)
    log.debug "Adding bit remote scope \"#{scope}\" to local workspace"

    return false unless configured? %w[bit_ssh bit_remote]

    return false unless _bit_scope_add_workspace_ready?

    # check if bit remote scope exists
    unless bit_scope_list.include? scope
      log.error "The bit remote bit scope \"#{scope}\" doesn't exist"
      return false
    end

    run "bit remote add #{config.active['bit_remote']}/#{scope}"

    log.info "Added bit remote scope \"#{scope}\" to local bit workspace"
  end

  # Backend method for bit scope inbit.
  def bit_scope_inbit
    log.debug 'Logging in to bit remote server'

    return false unless configured? %w[bit_ssh]

    run_and_exit config.active['bit_ssh']
  end

  # Backend method for bit scope list.
  # @return [String] list of bit scopes
  def bit_scope_list
    log.debug 'Listing bit remote scopes'

    return false unless configured? %w[bit_ssh bit_remote]

    # get ssh command from active config
    cmd_bit_ssh =
      config.active['bit_ssh']

    cmd_bit_scope_list = _bit_scope_list_cmd

    # run ssh command with scope list command
    scope_list = run "#{cmd_bit_ssh} '#{cmd_bit_scope_list}'"

    # remove bit remote root directory from results
    scope_list.gsub!(%r{#{root}/*}, '')

    # remove /scope.json from results
    scope_list.gsub!(%r{/scope.json}, '')

    scope_list
  end

  # Backend method for bit scope new.
  # @return [Int] status of new command
  def bit_scope_new(scope)
    log.debug "Creating new bit remote scope \"#{scope}\""

    return false unless configured? %w[bit_ssh bit_remote]

    return false if _bit_scope_exists? scope

    cmd_bit_ssh = config.active['bit_ssh']

    cmd_bit_scope_new = _bit_scope_new_cmd

    run "#{cmd_bit_ssh} '#{cmd_bit_scope_new}'"

    log.info "Created new bit remote scope \"#{scope}\""
  end

  private

  # Check if workspace ready for bit scope add.
  def _bit_scope_add_workspace_ready?
    unless bit_check_workspace
      log.error 'No bit workspace'
      return false
    end

    return true unless git_check_workspace

    return true if git_check_master

    log.error 'Not on git master branch'
    false
  end

  # Prepare bit scope list command.
  def _bit_scope_list_cmd
    root =
      config.active['bit_root']

    format(
      config.active['cmd_bit_scope_list_find_scopes'],
      root: root
    )
  end

  # Check if bit scope already exists.
  def _bit_scope_exists?(scope)
    scope_list = bit_scope_list
    return false unless scope_list.include? scope

    log.error "The remote bit scope \"#{scope}\" already exists"
    false
  end

  # Prepare bit scope new command.
  def _bit_scope_new_cmd
    root = config.active['bit_root']

    format(
      config.active['cmd_bit_scope_new_bit_init'],
      scope: scope,
      root: root
    )
  end
end
