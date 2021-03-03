# frozen_string_literal: true

# takelage info status ssh
module InfoStatusSSH
  # Backend method for info status ssh.
  # @return [Boolean] is ssh available?
  # rubocop:disable Metrics/MethodLength
  def info_status_ssh
    log.debug 'Check ssh status'

    unless _file_exists? _socket_get_agent_ssh_socket_path
      log.error 'gpg ssh socket is not available'
      return false
    end

    unless _info_status_ssh_keys
      log.error 'ssh keys are not available'
      return false
    end

    log.debug 'ssh is available'
    true
  end
  # rubocop:enable Metrics/MethodLength

  private

  # Check ssh keys
  def _info_status_ssh_keys
    status_keys = try config.active['cmd_info_status_ssh_keys']
    status_keys.exitstatus.zero?
  end
end
