# frozen_string_literal: true

# takelage info status ssh
module InfoStatusSSH
  # Backend method for info status ssh.
  # @return [Boolean] is ssh available?
  # rubocop:disable Metrics/MethodLength
  def info_status_ssh
    log.debug 'Check ssh status'

    ssh_auth_sock = ENV['SSH_AUTH_SOCK']
    gpg_ssh_socket = _info_status_ssh_socket_path

    unless ssh_auth_sock == gpg_ssh_socket
      log.error 'ssh does not use gpg ssh socket'
      return false
    end

    unless _file_exists? gpg_ssh_socket
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

  # Get ssh socket path
  def _info_status_ssh_socket_path
    run config.active['cmd_info_status_ssh_socket']
  end

  # Check ssh keys
  def _info_status_ssh_keys
    status_keys = try config.active['cmd_info_status_ssh_keys']
    status_keys.exitstatus.zero?
  end
end
