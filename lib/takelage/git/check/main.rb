# frozen_string_literal: true

# takelage git check main
module GitCheckMain
  # Backend method for git check main.
  # @return [Boolean] are we on the git main branch?
  def git_check_main
    log.debug 'Check if we are on the git main branch'

    return false unless git_check_workspace

    branch = _git_check_main_get_branch
    log.debug "We are on git branch \"#{branch}\""

    branch == config.active['git_main_branch']
  end

  private

  # Get git branch.
  def _git_check_main_get_branch
    cmd_get_branch =
      config.active['cmd_git_check_main_git_branch']
    (run cmd_get_branch).chomp.split('/')[-1]
  end
end
