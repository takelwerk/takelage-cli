# takelage git check module
module GitCheckModule

  # Backend method for git check clean.
  # @return [Boolean] is git workspace clean?
  def git_check_clean
    log.debug "Checking if git workspace is clean"

    return false unless git_check_workspace

    cmd_git_unstaged = config.active['git_unstaged']
    cmd_git_uncommitted = config.active['git_uncommitted']
    cmd_git_status = config.active['git_status']

    stdout_str, stderr_str, status_unstaged = run_and_check cmd_git_unstaged
    stdout_str, stderr_str, status_uncommitted = run_and_check cmd_git_uncommitted
    stdout_str_status, stderr_str, status = run_and_check cmd_git_status

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

    cmd_get_branch = config.active['git_branch']
    stdout_str, stderr_str, status = run_and_check cmd_get_branch

    branch = stdout_str.strip.split('/')[-1]

    log.debug "We are on git branch \"#{branch}\""

    branch == 'master'
  end

  # Backend method for git check workspace.
  # @return [Boolean] is this a git workspace?
  def git_check_workspace
    log.debug 'Check if this is a git workspace'

    cmd_git_repo = config.active['git_repo']
    stdout_str_repo, stderr_str_repo, status_repo = run_and_check cmd_git_repo

    cmd_pwd = config.active['pwd']
    stdout_str_dir, stderr_str_dir, status_dir = run_and_check cmd_pwd

    dir = stdout_str_dir.strip

    unless status_repo.exitstatus.zero?
      log.debug "No git workspace found in \"#{dir}\""
      return false
    end

    true
  end
end
