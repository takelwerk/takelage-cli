# frozen_string_literal: true

# tau git lib
module GitLib
  # Prepare git workspace.
  def git_lib_prepare_git_workspace
    log.debug 'Prepare git workspace'

    return false unless configured? %w[project_root_dir]

    unless git_check_hg
      log.error 'Not on git hg branch'
      return false
    end

    unless git_check_clean
      log.error 'No clean git workspace'
      return false
    end

    return true if _git_lib_git_pull_origin_hg

    log.error 'Unable to pull git workspace'
    false
  end

  # Push git workspace.
  def git_lib_push_hg_dirs
    log.info 'Pushing git workspace'

    message = 'Update .hg mercurial directories'

    return false unless _git_lib_git_add_hg_dirs

    # Do not fail or a clean workspace triggers a return
    _git_lib_git_commit message

    return true if _git_lib_git_push_origin_hg

    log.debug 'Unable to git push .hg mercurial directories'
    false
  end

  private

  # git add hg dirs.
  def _git_lib_git_add_hg_dirs
    log.debug 'Adding all .hg mercurial dirs to git'

    cmd_git_add_hg_dirs = config.active['cmd_git_lib_git_add_hg_dirs']

    return true if (try cmd_git_add_hg_dirs).exitstatus.zero?

    log.error 'Unable to add all .hg mercurial dirs to git'
    false
  end

  # git commit.
  def _git_lib_git_commit(message)
    log.debug "Committing to git with message \"#{message}\""

    cmd_git_commit = format(
      config.active['cmd_git_lib_git_commit'],
      message: message
    )

    return true if (try cmd_git_commit).exitstatus.zero?

    log.error 'Unable to commit to git'
    false
  end

  # git pull origin hg.
  def _git_lib_git_pull_origin_hg
    log.info 'Pulling git hg branch from origin'
    cmd_git_lib_git_pull_origin = format(
      config.active['cmd_git_lib_git_pull_origin'],
      main: config.active['git_hg_branch']
    )

    return true if (try cmd_git_lib_git_pull_origin).exitstatus.zero?

    log.error 'Unable to pull git hg branch'
    false
  end

  # git push origin hg.
  def _git_lib_git_push_origin_hg
    log.debug 'Pushing git hg branch to origin'

    cmd_git_lib_git_push_origin = format(
      config.active['cmd_git_lib_git_push_origin'],
      main: config.active['git_hg_branch']
    )

    return true if (try cmd_git_lib_git_push_origin).exitstatus.zero?

    log.error 'Unable to push git hg branch'
    false
  end
end
