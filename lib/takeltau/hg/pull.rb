# frozen_string_literal: true

# tau hg pull
module HgPull
  # Backend method for hg pull.
  def hg_pull
    log.debug 'Pull hg repos'

    return false unless git_lib_prepare_git_workspace

    _hg_pull_hg_pull_repos

    git_lib_push_hg_dirs
  end

  private

  # Pull hg repos.
  def _hg_pull_hg_pull_repos
    cmd_hg_pull_repos = format(
      config.active['cmd_hg_pull_repos'],
      root: config.active['project_root_dir']
    )

    log.info run cmd_hg_pull_repos
  end
end
