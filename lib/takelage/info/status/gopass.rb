# frozen_string_literal: true

# takelage info status gopass
module InfoStatusGopass
  # Backend method for info status gopass.
  # @return [Boolean] is gopass available?
  # rubocop:disable Metrics/MethodLength
  def info_status_gopass
    log.debug 'Check gopass status'

    root = _info_status_gopass_root_store.chomp

    if root.strip.empty?
      log.error 'gopass root store not found'
      return false
    end

    key = _info_status_lib_git_signingkey(root)

    unless _info_status_lib_git_key_available(key).exitstatus.zero?
      log.error 'gopass root store gpg key is not available'
      return false
    end

    log.debug 'gopass is available'
    true
  end
  # rubocop:enable Metrics/MethodLength

  private

  # Get gopass root store
  def _info_status_gopass_root_store
    cmd_gopass_root_store = config.active['cmd_info_status_gopass_root_store']
    run cmd_gopass_root_store
  end
end
