# takelage bit check module
module BitCheckModule

  # Backend method for bit check workspace.
  # @return [Boolean] is this a bit workspace?
  def bit_check_workspace
    log.debug 'Check if this is a bit workspace'

    cmd_bit_repo = config.active['bit_repo']
    stdout_str_repo, stderr_str_repo, status_repo = run_and_check cmd_bit_repo

    cmd_pwd = config.active['pwd']
    stdout_str_dir, stderr_str_dir, status_dir = run_and_check cmd_pwd

    dir = stdout_str_dir.strip

    unless status_repo.exitstatus.zero?
      log.debug "No bit workspace found in \"#{dir}\""
      return false
    end

    true
  end
end
