# frozen_string_literal: true

# tau hg pull
module HgPull
  # Backend method for hg pull.
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
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

    log.info _hg_pull_hg_pull_repos

    return true if git_lib_push_hg_dirs

    log.error 'Unable to push .hg mercurial directories'
    false
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  private

  # Pull hg repos.
  def _hg_pull_hg_pull_repos
    cmd_hg_pull_repos = format(
      config.active['cmd_hg_pull_repos'],
      root: config.active['project_root_dir']
    )

    run cmd_hg_pull_repos
  end
end
