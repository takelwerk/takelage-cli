# frozen_string_literal: true

# takelage info status gpg
module InfoStatusGPG
  # Backend method for info status gpg.
  # @return [Boolean] is GPG available?
  def info_status_gpg
    log.debug 'Check gpg status'

    unless _info_status_gpg_status
      log.error 'GPG is not available'
      return false
    end

    log.debug 'GPG is available'
    true
  end

  private

  def _info_status_gpg_status
    status_agent = try config.active['cmd_info_status_gpg_agent']
    status_keys = try config.active['cmd_info_status_gpg_keys']

    status_agent.exitstatus.zero? && status_keys.exitstatus.zero?
  end
end
