# frozen_string_literal: true

# tau hg export
module HgExport
  # Backend method for hg export.
  def hg_export
    log.debug 'Export hg repos'

    return false unless configured? %w[project_root_dir]

    cmd_hg_export_repos = format(
      config.active['cmd_hg_export_repos'],
      root: config.active['project_root_dir']
    )

    run cmd_hg_export_repos
  end
end
