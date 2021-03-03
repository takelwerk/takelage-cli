# frozen_string_literal: true

# takelage info status git
module InfoStatusGit
  # Backend method for info status git.
  # @return [Boolean] is the git gpg signing key available?
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def info_status_git
    log.debug 'Check git status'

    root = config.active['project_root_dir']

    if root.chomp.empty?
      log.error 'Cannot determine project root directory'
      log.info 'Is there a Rakefile in the project root directory?'
      return false
    end

    unless git_check_workspace(root)
      log.error 'Project root directory is not a git workspace'
      return false
    end

    if _info_status_lib_git_name(root).chomp.empty?
      log.error 'git config user.name is not available'
      return false
    end

    if _info_status_lib_git_email(root).chomp.empty?
      log.error 'git config user.email is not available'
      return false
    end

    key = _info_status_lib_git_signingkey(root)

    unless _info_status_lib_git_key_available(key).exitstatus.zero?
      log.error 'git config user.signingkey is not available'
      return false
    end

    log.debug 'git config is available'
    true
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
