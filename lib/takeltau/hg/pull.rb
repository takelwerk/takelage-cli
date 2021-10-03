# frozen_string_literal: true

# tau hg pull
module HgPull
  # Backend method for hg pull.
  def hg_pull
    log.debug 'Pull hg repos'

    return false unless configured? %w[project_root_dir]

    unless git_check_hg
      log.error 'Not on git hg branch'
      return false
    end

    unless git_check_clean
      log.error 'No clean git workspace'
      return false
    end

    unless git_lib_pull_workspace
      log.error 'Unable to pull git workspace'
      return false
    end

    _hg_pull_hg_pull_repos
  end

  private

  # Pull hg repos.
  def _hg_pull_hg_pull_repos
    cmd_hg_pull_repos = format(
      config.active['cmd_hg_pull_repos'],
      root: config.active['project_root_dir']
    )

    return true if try cmd_hg_pull_repos

    log.error 'Unable to pull hg repos'
    false
  end
end
