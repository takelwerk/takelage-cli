# frozen_string_literal: true

# takelage git check module
module GitCheckModule
  # Backend method for git check clean.
  # @return [Boolean] is git workspace clean?
  def git_check_clean
    log.debug 'Checking if git workspace is clean'

    return false unless git_check_workspace

    status_unstaged = _git_get_status_unstaged
    status_uncommitted = _git_get_status_uncommitted
    stdout_str_status = _git_get_str_status

    # only return true if neither unstaged nor uncommitted nor empty files
    sum = status_unstaged.exitstatus +
          status_uncommitted.exitstatus +
          stdout_str_status.length

    sum.zero?
  end

  # Backend method for git check master.
  # @return [Boolean] are we on the git master branch?
  def git_check_master
    log.debug 'Check if we are on the git master branch'

    return false unless git_check_workspace

    branch = _git_get_branch
    log.debug "We are on git branch \"#{branch}\""

    branch == 'master'
  end

  # Backend method for git check workspace.
  # @return [Boolean] is this a git workspace?
  def git_check_workspace
    log.debug 'Check if this is a git workspace'
    status_repo = _git_get_status_repo
    dir = _git_get_dir
    unless status_repo.exitstatus.zero?
      log.debug "No git workspace found in \"#{dir}\""
      return false
    end
    true
  end

  private

  # Get git status of unstaged changes.
  def _git_get_status_unstaged
    cmd_git_unstaged =
      config.active['cmd_git_check_clean_git_unstaged']
    try cmd_git_unstaged
  end

  # Get git status of uncommitted changes.
  def _git_get_status_uncommitted
    cmd_git_uncommitted =
      config.active['cmd_git_check_clean_git_uncommitted']
    try cmd_git_uncommitted
  end

  # Get git status result.
  def _git_get_str_status
    cmd_git_status =
      config.active['cmd_git_check_clean_git_status']
    run cmd_git_status
  end

  # Get git branch.
  def _git_get_branch
    cmd_get_branch =
      config.active['cmd_git_check_master_git_branch']
    (run cmd_get_branch).strip.split('/')[-1]
  end

  # Get git repository status.
  def _git_get_status_repo
    cmd_git_repo =
      config.active['cmd_git_check_workspace_git_repo']
    try cmd_git_repo
  end

  # Get current working directory.
  def _git_get_dir
    cmd_pwd =
      config.active['cmd_git_check_workspace_pwd']
    (run cmd_pwd).strip
  end
end
