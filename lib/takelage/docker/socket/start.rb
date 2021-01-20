# frozen_string_literal: true

# takelage docker socket start
module DockerSocketStart
  # Backend method for docker socket start.
  def docker_socket_start
    log.debug 'Starting sockets for docker container'

    return false unless docker_check_daemon

    return false unless docker_check_socat

    cmds_start_socket = _docker_socket_lib_get_socket_start_commands 'start'

    return true if cmds_start_socket.empty?

    _docker_socket_start_get_sudo

    cmds_start_socket.each do |cmd_start_socket|
      run_and_fork cmd_start_socket
    end

    true
  end

  private

  # Get sudo.
  def _docker_socket_start_get_sudo
    log.debug 'Request sudo so that ' \
      'subsequent background tasks run without delay'
    cmd_sudo_true =
      config.active['cmd_docker_socket_start_sudo_true']
    run cmd_sudo_true
  end
end
