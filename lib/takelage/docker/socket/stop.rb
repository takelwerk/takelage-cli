# frozen_string_literal: true

# takelage docker socket stop
module DockerSocketStop
  # Backend method for docker socket stop.
  def docker_socket_stop
    log.debug 'Stopping sockets for docker container'

    return false unless docker_check_daemon

    return false unless docker_check_socat

    # get process list
    # assuming format: "pid command"
    cmd_ps = config.active['cmd_docker_socket_stop_docker_socket_ps']

    stdout_str = run cmd_ps

    cmds_start_socket = _docker_socket_lib_get_socket_start_commands 'stop'

    # loop over process list
    stdout_str.split(/\n+/).each do |process|
      _docker_socket_stop_kill_process process, cmds_start_socket
    end

    true
  end

  private

  # Stop process.
  def _docker_socket_stop_kill_process(process, cmds_start_socket)
    # split processes in process id and process command
    pid_command = process.chomp.split(/ /, 2)
    pid = pid_command[0]
    command = pid_command[1]

    # loop over socket start commands
    cmds_start_socket.each do |cmd_start_socket|
      next unless command == cmd_start_socket

      _docker_socket_stop_kill_pid pid
    end
  end

  # Kill process.
  def _docker_socket_stop_kill_pid(pid)
    log.debug "Killing PID #{pid}"
    cmd_kill =
      format(
        config.active['cmd_docker_socket_stop_docker_socket_kill'],
        pid: pid
      )
    run cmd_kill
  end
end
