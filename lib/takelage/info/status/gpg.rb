# frozen_string_literal: true

# takelage info status gpg
module InfoStatusGPG
  # Backend method for info status gpg.
  # @return [Boolean] is GPG available?
  # rubocop:disable Metrics/MethodLength
  def info_status_gpg
    log.debug 'Check gpg status'

    unless _info_status_gpg_keys
      log.error 'gpg keys are not available'
      return false
    end

    unless _info_status_gpg_agent
      log.error 'gpg agent is not available'
      return false
    end

    log.debug 'gpg is available'
    true
  end
  # rubocop:enable Metrics/MethodLength

  private

  def _info_status_gpg_keys
    status_keys = try config.active['cmd_info_status_gpg_keys']
    status_keys.exitstatus.zero?
  end

  def _info_status_gpg_agent
    status_agent = try config.active['cmd_info_status_gpg_agent']
    status_agent.exitstatus.zero?
  end
end
