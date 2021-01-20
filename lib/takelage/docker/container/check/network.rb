# frozen_string_literal: true

# takelage docker container check network
module DockerContainerCheckNetwork
  # Backend method for docker container check network.
  # @return [Boolean] is network existing?
  def docker_container_check_network(network)
    log.debug "Checking if network \"#{network}\" is existing"

    return false unless docker_check_daemon

    stdout_str = run _docker_container_cmd_check_network network

    if stdout_str.to_s.strip.empty?
      log.debug "Network \"#{network}\" is not existing"
      return false
    end

    log.debug "Network \"#{network}\" is existing"
    true
  end

  private

  # Prepare command to check if docker network exists.
  def _docker_container_cmd_check_network(network)
    format(
      config.active['cmd_docker_container_check_network_docker_network'],
      network: network
    )
  end
end
