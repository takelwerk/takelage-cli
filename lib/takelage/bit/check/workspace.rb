# frozen_string_literal: true

# takelage bit check workspace
module BitCheckWorkspace
  # Backend method for bit check workspace.
  # @return [Boolean] is this a bit workspace?
  def bit_check_workspace
    log.debug 'Check if this is a bit workspace'

    status_repo = _bit_check_workspace_bit_repo
    return true if status_repo.exitstatus.zero?

    dir = _bit_check_workspace_dir
    log.debug "No bit workspace found in \"#{dir}\""
    false
  end

  private

  # Check bit repo.
  def _bit_check_workspace_bit_repo
    cmd_bit_repo =
      config.active['cmd_bit_check_workspace_bit_list']

    try cmd_bit_repo
  end

  # Get current working directory.
  def _bit_check_workspace_dir
    cmd_pwd =
      config.active['cmd_bit_check_workspace_pwd']

    stdout_str_dir = run cmd_pwd

    stdout_str_dir.chomp
  end
end
