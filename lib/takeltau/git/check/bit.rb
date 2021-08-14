# frozen_string_literal: true

# takeltau git check bit
module GitCheckBit
  # Backend method for git check bit.
  # @return [Boolean] are we on the git bit branch?
  def git_check_bit
    log.debug 'Check if we are on the git bit branch'

    return false unless git_check_workspace

    branch = _git_check_bit_get_branch
    log.debug "We are on git branch \"#{branch}\""

    branch == config.active['git_bit_branch']
  end

  private

  # Get git branch.
  def _git_check_bit_get_branch
    cmd_get_branch =
      config.active['cmd_git_check_bit_get_git_branch']
    (run cmd_get_branch).chomp.split('/')[-1]
  end
end
