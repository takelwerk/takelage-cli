# frozen_string_literal: true

# takelage bit scope add
module BitScopeAdd
  # Backend method for bit scope add.
  def bit_scope_add(scope)
    log.debug "Adding bit remote scope \"#{scope}\" to local workspace"

    return false unless configured? %w[bit_ssh bit_remote]

    return false unless _bit_scope_add_workspace_ready?

    return false unless _bit_scope_add_scope_exists? scope

    run _bit_scope_add_cmd scope

    log.info "Added bit remote scope \"#{scope}\" to local bit workspace"
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

  # Check if bit remote scope exists.
  def _bit_scope_add_scope_exists?(scope)
    return true if bit_scope_list.include? scope

    log.error "The bit remote bit scope \"#{scope}\" doesn't exist"
    false
  end

  # Prepare bit add scope command.
  def _bit_scope_add_cmd(scope)
    remote = config.active['bit_remote']

    format(
      config.active['cmd_bit_scope_add_scope'],
      remote: remote,
      scope: scope
    )
  end
end
