# frozen_string_literal: true

# tau git check workspace
module GitCheckWorkspace
  # Backend method for git check workspace.
  # @return [Boolean] is this a git workspace?
  def git_check_workspace(dir = _git_check_workspace_get_dir)
    log.debug "Check if \"#{dir}\" is a git workspace"
    status_repo = _git_check_workspace_get_status_repo(dir)
    unless status_repo.exitstatus.zero?
      log.debug "No git workspace found in \"#{dir}\""
      return false
    end
    true
  end

  private

  # Get git repository status.
  def _git_check_workspace_get_status_repo(dir)
    cmd_git_repo = format(
      config.active['cmd_git_check_workspace_git_repo'],
      dir: dir
    )
    try cmd_git_repo
  end

  # Get current working directory.
  def _git_check_workspace_get_dir
    cmd_pwd =
      config.active['cmd_git_check_workspace_pwd']
    (run cmd_pwd).chomp
  end
end
