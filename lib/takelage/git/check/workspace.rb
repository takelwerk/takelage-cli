# frozen_string_literal: true

# takelage git check workspace
module GitCheckWorkspace
  # Backend method for git check workspace.
  # @return [Boolean] is this a git workspace?
  def git_check_workspace
    log.debug 'Check if this is a git workspace'
    status_repo = _git_check_workspace_get_status_repo
    dir = _git_check_workspace_get_dir
    unless status_repo.exitstatus.zero?
      log.debug "No git workspace found in \"#{dir}\""
      return false
    end
    true
  end

  private

  # Get git repository status.
  def _git_check_workspace_get_status_repo
    cmd_git_repo = config.active['cmd_git_check_workspace_git_repo']
    try cmd_git_repo
  end

  # Get current working directory.
  def _git_check_workspace_get_dir
    cmd_pwd =
      config.active['cmd_git_check_workspace_pwd']
    (run cmd_pwd).strip
  end
end
