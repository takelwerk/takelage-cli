# frozen_string_literal: true

# tau git check clean
module GitCheckClean
  # Backend method for git check clean.
  # @return [Boolean] is git workspace clean?
  def git_check_clean
    log.debug 'Checking if git workspace is clean'

    return false unless git_check_workspace

    status_unstaged = _git_check_clean_get_status_unstaged
    status_uncommitted = _git_check_clean_get_status_uncommitted
    stdout_str_status = _git_check_clean_get_str_status

    # only return true if neither unstaged nor uncommitted nor empty files
    sum = status_unstaged.exitstatus +
          status_uncommitted.exitstatus +
          stdout_str_status.length

    sum.zero?
  end

  private

  # Get git status of unstaged changes.
  def _git_check_clean_get_status_unstaged
    cmd_git_unstaged =
      config.active['cmd_git_check_clean_git_unstaged']
    try cmd_git_unstaged
  end

  # Get git status of uncommitted changes.
  def _git_check_clean_get_status_uncommitted
    cmd_git_uncommitted =
      config.active['cmd_git_check_clean_git_uncommitted']
    try cmd_git_uncommitted
  end

  # Get git status result.
  def _git_check_clean_get_str_status
    cmd_git_status =
      config.active['cmd_git_check_clean_git_status']
    run cmd_git_status
  end
end
