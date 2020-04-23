# frozen_string_literal: true

# takelage git check master
module GitCheckMaster
  # Backend method for git check master.
  # @return [Boolean] are we on the git master branch?
  def git_check_master
    log.debug 'Check if we are on the git master branch'

    return false unless git_check_workspace

    branch = _git_check_master_get_branch
    log.debug "We are on git branch \"#{branch}\""

    branch == 'master'
  end

  private

  # Get git branch.
  def _git_check_master_get_branch
    cmd_get_branch =
      config.active['cmd_git_check_master_git_branch']
    (run cmd_get_branch).strip.split('/')[-1]
  end
end
