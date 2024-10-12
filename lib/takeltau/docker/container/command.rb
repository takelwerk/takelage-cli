# frozen_string_literal: true

# tau docker container command
module DockerContainerCommand
  # Backend method for docker container command.
  def docker_container_command(command)
    log.debug 'Running command in container'

    return false unless docker_check_daemon

    # no matrjoschka test here

    unless docker_container_check_existing @hostname
      return false unless _docker_container_lib_create_net_and_ctr @hostname

      _docker_container_lib_start_sockets
    end

    _docker_container_command_run_command @hostname, command
  end

  private

  # Prepare run command in container command.
  def _docker_container_command_run_command(container, command)
    log.debug "Running command \"#{command}\" in container \"#{container}\""

    cmd_docker_run_command =
      format(
        config.active['cmd_docker_container_docker_exec'],
        docker: config.active['cmd_docker'],
        container: container,
        username: @username,
        command: command
      )

    run_and_exit cmd_docker_run_command
  end
end
