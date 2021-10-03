# frozen_string_literal: true

# tau git check hg
module GitCheckHg
  # Backend method for git check hg.
  # @return [Boolean] are we on the git hg branch?
  def git_check_hg
    log.debug 'Check if we are on the git hg branch'

    return false unless git_check_workspace

    branch = _git_check_hg_get_branch
    log.debug "We are on git branch \"#{branch}\""

    branch == config.active['git_hg_branch']
  end

  private

  # Get git branch.
  def _git_check_hg_get_branch
    cmd_get_branch =
      config.active['cmd_git_check_hg_get_git_branch']
    (run cmd_get_branch).chomp.split('/')[-1]
  end
end
