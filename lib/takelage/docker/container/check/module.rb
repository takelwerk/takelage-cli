# frozen_string_literal: true

# takelage docker container check module
module DockerContainerCheckModule
  # Backend method for docker container check existing.
  # @return [Boolean] is container existing?
  def docker_container_check_existing(container)
    log.debug "Checking if container \"#{container}\" is existing"

    return false unless docker_check_running

    stdout_str = run _docker_container_cmd_check_existing container

    if stdout_str.to_s.strip.empty?
      log.debug "Container \"#{container}\" is not existing"
      return false
    end

    log.debug "Container \"#{container}\" is existing"
    true
  end

  # Backend method for docker container check network.
  # @return [Boolean] is network existing?
  def docker_container_check_network(network)
    log.debug "Checking if network \"#{network}\" is existing"

    return false unless docker_check_running

    stdout_str = run _docker_container_cmd_check_network network

    if stdout_str.to_s.strip.empty?
      log.debug "Network \"#{network}\" is not existing"
      return false
    end

    log.debug "Network \"#{network}\" is existing"
    true
  end

  # Backend method for docker container check orphaned.
  # @return [Boolean] is container orphaned?
  def docker_container_check_orphaned(container)
    log.debug "Check if container \"#{container}\" is orphaned"

    return false unless docker_check_running

    stdout_str = run _docker_container_cmd_check_orphaned container

    if stdout_str.include? '/loginpoint.py'
      log.debug "Container \"#{container}\" isn't orphaned"
      return false
    end

    log.debug "Container \"#{container}\" is orphaned"
    true
  end

  private

  def _docker_container_cmd_check_existing(container)
    format(
      config.active['cmd_docker_container_check_existing_docker_ps'],
      container: container
    )
  end

  def _docker_container_cmd_check_network(network)
    format(
      config.active['cmd_docker_container_check_network_docker_network'],
      network: network
    )
  end

  def _docker_container_cmd_check_orphaned(container)
    format(
      config.active['cmd_docker_container_check_orphaned_docker_exec'],
      container: container
    )
  end
end
