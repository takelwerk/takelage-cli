# frozen_string_literal: true

# takelage docker socket module
module DockerSocketModule
  # Backend method for docker socket scheme.
  def docker_socket_scheme
    log.debug 'Getting docker socket scheme'

    gpg_path = _socket_get_agent_socket_path
    gpg_port = config.active['docker_socket_gpg_agent_port']
    ssh_path = _socket_get_agent_ssh_socket_path
    ssh_port = config.active['docker_socket_gpg_ssh_agent_port']

    socket_scheme = _socket_get_scheme gpg_path, gpg_port, ssh_path, ssh_port
    log.debug 'Docker socket scheme is ' \
      "\n\"\"\"\n#{hash_to_yaml socket_scheme}\"\"\""

    socket_scheme
  end

  # Backend method for docker socket host.
  def docker_socket_host
    log.debug 'Getting docker socket host ip address'

    socket_host = '127.0.0.1'

    addr_infos = Socket.getifaddrs

    # if interface docker0 exists (== linux host)
    # then return the ip address
    addr_infos.each do |addr_info|
      if addr_info.name == 'docker0'
        socket_host = addr_info.addr.ip_address if addr_info.addr.ipv4?
      end
    end

    log.debug "Docker socket host ip address is \"#{socket_host}\""

    socket_host
  end

  # Backend method for docker socket start.
  def docker_socket_start
    log.debug 'Starting sockets for docker container'

    return false unless docker_check_running

    cmds_start_socket = _get_socket_start_commands 'start'

    return true unless cmds_start_socket.empty?

    _socket_get_sudo

    cmds_start_socket.each do |cmd_start_socket|
      run_and_fork cmd_start_socket
    end

    true
  end

  # Backend method for docker socket stop.
  def docker_socket_stop
    log.debug 'Stopping sockets for docker container'

    return false unless docker_check_running

    # get process list
    # assuming format: "pid command"
    cmd_ps =
      config.active['cmd_docker_socket_stop_docker_socket_ps']

    stdout_str = run cmd_ps

    # loop over process list
    stdout_str.split(/\n+/).each do |process|
      _socket_stop_process process
    end

    true
  end

  private

  # Get gpg agent socket path.
  def _socket_get_agent_socket_path
    cmd_agent_socket_path =
      config.active['cmd_docker_socket_config_agent_socket_path']
    (run cmd_agent_socket_path).chomp
  end

  # Get gpg ssh agent socket path.
  def _socket_get_agent_ssh_socket_path
    cmd_agent_ssh_socket_path =
      config.active['cmd_docker_socket_config_agent_ssh_socket_path']
    (run cmd_agent_ssh_socket_path).chomp
  end

  # Create socket scheme.
  def _socket_get_scheme(gpg_path, gpg_port, ssh_path, ssh_port)
    { 'agent-socket' => { 'path' => gpg_path,
                          'host' => @socket_host,
                          'port' => gpg_port },
      'agent-ssh-socket' => { 'path' => ssh_path,
                              'host' => @socket_host,
                              'port' => ssh_port } }
  end

  # Get socket start commands.
  # sockets_up is a boolean which defines if the sockets need to be up
  # to be included in the resulting array of socket start commands
  def _get_socket_start_commands(mode)
    cmds_start_socket = []

    # loop over sockets
    @sockets.each do |socket, socket_config|
      host = socket_config['host']
      port = socket_config['port']
      path = socket_config['path']

      cmd = _get_socket_start_command mode, socket, host, port, path
      cmds_start_socket.push cmd if cmd
    end

    cmds_start_socket
  end

  # Get socket start command
  def _get_socket_start_command(mode, socket, host, port, path)
    if mode == 'start'
      if _socket_up? socket, host, port, path
        return _socket_get_cmd_start_socket(host, port, path)
      end
    else
      unless _socket_up? socket, host, port, path
        return _socket_get_cmd_start_socket(host, port, path)
      end
    end
    nil
  end

  # Get socket start command.
  def _socket_get_cmd_start_socket(host, port, path)
    format(
      config.active['cmd_docker_socket_get_start'],
      host: host,
      port: port,
      path: path
    )
  end

  # Check if a socket is available by trying to connect to it via TCP
  def _socket_up?(socket, host, port, path)
    error_message = _socket_get_error_message socket, host, port, path
    begin
      Timeout.timeout(1) do
        return false unless _socket_test socket, host, port, error_message
      end
    rescue Timeout::Error
      log.debug "Timeout: #{error_message}"
      false
    end
  end

  # Create error message.
  def _socket_get_error_message(socket, host, port, path)
    'failed to connect to ' \
        "socket \"#{socket}\" " \
        "using host \"#{host}\", " \
        "port \"#{port}\", " \
        "path \"#{path}\""
  end

  # Test socket.
  # rubocop:disable Metrics/MethodLength
  def _socket_test(socket, host, port, error_message)
    begin
      s = TCPSocket.new host, port
      s.close
      log.debug "Socket \"#{socket}\" available"
      true
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

  # Kill process.
  def _socket_kill_pid
    log.debug "Killing PID #{pid}"
    cmd_kill =
      format(
        config.active['cmd_docker_socket_stop_docker_socket_kill'],
        pid: pid
      )
    run cmd_kill
  end

  # Get sudo.
  def _socket_get_sudo
    log.debug 'Request sudo so that ' \
      'subsequent background tasks run without delay'
    cmd_sudo_true =
      config.active['cmd_docker_socket_start_sudo_true']
    run cmd_sudo_true
  end

  # Stop process.
  def _socket_stop_process(process)
    # split processes in process id and process command
    pid_command = process.strip.split(/ /, 2)
    pid = pid_command[0]
    command = pid_command[1]

    cmds_start_socket = _get_socket_start_commands 'stop'

    # loop over socket start commands
    cmds_start_socket.each do |cmd_start_socket|
      next unless command == cmd_start_socket

      _socket_kill pid
    end
  end
end
