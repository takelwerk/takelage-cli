# frozen_string_literal: true

# tau hg push
module HgPush
  # Backend method for hg push.
  def hg_push
    log.debug 'Push hg repos'

    return false unless git_lib_prepare_git_workspace

    _hg_push_hg_push_repos

    git_lib_push_hg_dirs
  end

  private

  # Push hg repos.
  def _hg_push_hg_push_repos
    cmd_hg_push_repos = format(
      config.active['cmd_hg_push_repos'],
      root: config.active['project_root_dir']
    )

    log.info run cmd_hg_push_repos
  end
end
