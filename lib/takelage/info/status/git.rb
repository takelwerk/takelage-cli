# frozen_string_literal: true

# takelage info status git
module InfoStatusGit
  # Backend method for info status git.
  # @return [Boolean] is the git gpg signing key available?
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def info_status_git
    log.debug 'Check git status'

    projectroot = config.active['project_root_dir']

    if projectroot.strip.empty?
      log.error 'Cannot determine project root directory'
      log.info 'Is there a Rakefile in the project root directory?'
      return false
    end

    if _info_status_git_name.strip.empty?
      log.error 'git config user.name is not available'
      return false
    end

    if _info_status_git_email.strip.empty?
      log.error 'git config user.email is not available'
      return false
    end

    unless _info_status_git_signingkey_available.exitstatus.zero?
      log.error 'git config user.signingkey is not available'
      return false
    end

    log.debug 'git config is available'
    true
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def _info_status_git_name
    cmd_git_name =
      format(
        config.active['cmd_info_status_git_name'],
        projectroot: config.active['project_root_dir']
      )
    run cmd_git_name
  end

  def _info_status_git_email
    cmd_git_email =
      format(
        config.active['cmd_info_status_git_email'],
        projectroot: config.active['project_root_dir']
      )
    run cmd_git_email
  end

  def _info_status_git_signingkey
    cmd_git_signingkey =
      format(
        config.active['cmd_info_status_git_signingkey'],
        projectroot: config.active['project_root_dir']
      )
    run cmd_git_signingkey
  end

  def _info_status_git_signingkey_available
    cmd_git_signingkey_available =
      format(
        config.active['cmd_info_status_git_key_available'],
        key: _info_status_git_signingkey
      )
    try cmd_git_signingkey_available
  end
end
