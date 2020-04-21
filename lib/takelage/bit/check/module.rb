# frozen_string_literal: true

# takelage bit check module
module BitCheckModule
  # Backend method for bit check workspace.
  # @return [Boolean] is this a bit workspace?
  def bit_check_workspace
    log.debug 'Check if this is a bit workspace'

    cmd_bit_repo =
        config.active['cmd_bit_check_workspace_bit_list']

    status_repo = try cmd_bit_repo

    cmd_pwd =
        config.active['cmd_bit_check_workspace_pwd']

    stdout_str_dir = run cmd_pwd

    dir = stdout_str_dir.strip

    unless status_repo.exitstatus.zero?
      log.debug "No bit workspace found in \"#{dir}\""
      return false
    end

    true
  end
end
