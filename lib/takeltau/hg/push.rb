# frozen_string_literal: true

# tau hg push
module HgPush
  # Backend method for hg push.
  # rubocop:disable Metrics/MethodLength
  def hg_push
    log.debug 'Push hg repos'

    return false unless configured? %w[project_root_dir]

    unless git_check_hg
      log.error 'Not on git hg branch'
      return false
    end

    unless git_check_clean
      log.error 'No clean git workspace'
      return false
    end

    log.info _hg_push_hg_push_repos

    return true if git_lib_push_workspace 'tau hg push'

    log.error 'Unable to push git workspace'
    false
  end
  # rubocop:enable Metrics/MethodLength

  private

  # Push hg repos.
  def _hg_push_hg_push_repos
    cmd_hg_push_repos = format(
      config.active['cmd_hg_push_repos'],
      root: config.active['project_root_dir']
    )

    run cmd_hg_push_repos
  end
end
