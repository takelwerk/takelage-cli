# frozen_string_literal: true

# tau hg list
module HgList
  # Backend method for hg list.
  def hg_list
    log.debug 'List hg repos'

    return false unless configured? %w[project_root_dir]

    cmd_hg_list_repos = format(
      config.active['cmd_hg_list_repos'],
      root: config.active['project_root_dir']
    )

    run cmd_hg_list_repos
  end
end
