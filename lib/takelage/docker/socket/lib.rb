# frozen_string_literal: true

# takelage docker socket lib
module DockerSocketLib
  private

  # Get socket start commands.
  # sockets_up is a boolean which defines if the sockets need to be up
  # to be included in the resulting array of socket start commands
  def _docker_socket_lib_get_socket_start_commands(mode)
    cmds_start_socket = []

    # loop over sockets
    @sockets.each do |socket, socket_config|
      host = socket_config['host']
      port = socket_config['port']
      path = socket_config['path']

      cmd = _docker_socket_lib_get_start_cmd(mode, socket, host, port, path)
      cmds_start_socket.push cmd if cmd
    end

    cmds_start_socket
  end

  # Get socket start command.
  def _docker_socket_lib_get_start_cmd(mode, socket, host, port, path)
    if mode == 'start'
      unless _docker_socket_lib_socket_up? socket, host, port, path
        return _docker_socket_lib_start_cmd(host, port, path)
      end
    elsif _docker_socket_lib_socket_up? socket, host, port, path
      return _docker_socket_lib_start_cmd(host, port, path)
    end
    nil
  end

  # Get socket start command.
  def _docker_socket_lib_start_cmd(host, port, path)
    format(
      config.active['cmd_docker_socket_get_start'],
      host: host,
      port: port,
      path: path
    )
  end

  # Check if a socket is available by trying to connect to it via TCP.
  def _docker_socket_lib_socket_up?(socket, host, port, path)
    error_message = _docker_socket_lib_error_msg socket, host, port, path
    begin
      Timeout.timeout(1) do
        _docker_socket_lib_socket_reachable? socket, host, port, error_message
      end
    rescue Timeout::Error
      log.debug "Timeout: #{error_message}"
      false
    end
  end

  # Create error message.
  def _docker_socket_lib_error_msg(socket, host, port, path)
    'failed to connect to ' \
        "socket \"#{socket}\" " \
        "using host \"#{host}\", " \
        "port \"#{port}\", " \
        "path \"#{path}\""
  end

  # Test socket.
  # rubocop:disable Metrics/MethodLength
  def _docker_socket_lib_socket_reachable?(socket, host, port, error_message)
    begin
      s = TCPSocket.new host, port
      s.close
      log.debug "Socket \"#{socket}\" up"
      return true
    rescue Errno::ECONNREFUSED
      log.debug "Connection refused: #{error_message}"
    rescue Errno::EHOSTUNREACH
      log.debug "Host unreachable: #{error_message}"
    rescue SocketError
      log.debug "Socket error: #{error_message}"
    end
    false
  end
  # rubocop:enable Metrics/MethodLength
end
