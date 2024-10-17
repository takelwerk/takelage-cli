# frozen_string_literal: true

# tau docker container daemon
module DockerContainerDaemon
  # Backend method for docker container daemon.
  def docker_container_daemon
    log.debug 'Starting docker container as daemon'

    result = _docker_container_lib_create_net_and_ctr @hostname

    _docker_container_lib_start_sockets

    result
  end
end
