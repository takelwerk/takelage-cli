# takelage docker socket module
module DockerSocketModule

  # Backend method for docker socket scheme.
  def docker_socket_scheme
    log.debug 'Getting docker socket scheme'

    cmd_agent_socket_path =
        config.active['cmd_docker_socket_config_agent_socket_path']

    agent_socket_path = run cmd_agent_socket_path
    agent_socket_path.chomp!

    agent_socket_port =
        config.active['docker_socket_gpg_agent_port']

    cmd_agent_ssh_socket_path =
        config.active['cmd_docker_socket_config_agent_ssh_socket_path']

    agent_ssh_socket_path = run cmd_agent_ssh_socket_path
    agent_ssh_socket_path.chomp!

    agent_ssh_socket_port =
        config.active['docker_socket_gpg_ssh_agent_port']

    socket_scheme = {
        'agent-socket' => {
            'path' => agent_socket_path,
            'host' => @socket_host,
            'port' => agent_socket_port
        },
        'agent-ssh-socket' => {
            'path' => agent_ssh_socket_path,
            'host' => @socket_host,
            'port' => agent_ssh_socket_port
        }
    }

    log.debug "Docker socket scheme is \n\"\"\"\n#{hash_to_yaml socket_scheme}\"\"\""

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

    cmds_start_socket = _get_socket_start_commands sockets_up = false

    unless cmds_start_socket.empty?
      log.debug 'Request sudo so that subsequent background tasks run without delay'

      cmd_sudo_true =
          config.active['cmd_docker_socket_start_sudo_true']

      run cmd_sudo_true
    end

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

    cmds_start_socket = _get_socket_start_commands sockets_up = true

    # loop over process list
    stdout_str.split(/\n+/).each do |process|

      # split processes in process id and process command
      pid_command = process.strip.split(/ /, 2)
      pid = pid_command[0]
      command = pid_command[1]

      # loop over socket start commands
      cmds_start_socket.each do |cmd_start_socket|

        if command == cmd_start_socket
          log.debug "Killing PID #{pid}"

          cmd_kill =
              config.active['cmd_docker_socket_stop_docker_socket_kill'] % {
                  pid: pid
              }

          run cmd_kill
        end
      end
    end

    true
  end

  # get socket start commands
  # sockets_up is a boolean which defines if the sockets need to be up
  # to be included in the resulting array of socket start commands
  def _get_socket_start_commands sockets_up
    cmds_start_socket = []

    # loop over sockets
    @sockets.each do |socket, socket_config|
      cmd_start_socket =
          config.active['cmd_docker_socket_get_start'] % {
              port: socket_config['port'],
              host: socket_config['host'],
              path: socket_config['path'],
          }

      if sockets_up
        if _socket_up? socket, socket_config
          cmds_start_socket << cmd_start_socket
        end
      else
        unless _socket_up? socket, socket_config
          cmds_start_socket << cmd_start_socket
        end
      end
    end

    cmds_start_socket
  end

  # check if a socket is available
  # but trying to connect to it via TCP
  def _socket_up? socket, socket_config
    host = socket_config['host']
    port = socket_config['port']
    path = socket_config['path']

    error_message = "failed to connect to " +
        "socket \"#{socket}\" " +
        "using host \"#{host}\", " +
        "port \"#{port}\", " +
        "path \"#{path}\""

    # check if socket is available
    begin
      Timeout::timeout(1) do
        begin
          s = TCPSocket.new host, port
          s.close
          log.debug "Socket \"#{socket}\" available"
          return true
        rescue Errno::ECONNREFUSED
          log.debug "Connection refused: #{error_message}"
          return false
        rescue Errno::EHOSTUNREACH
          log.debug "Host unreachable: #{error_message}"
          return false
        rescue SocketError
          log.debug "Socket error: #{error_message}"
          return false
        end
      end
    rescue Timeout::Error
      log.debug "Timeout: #{error_message}"
      return false
    end
  end
end
