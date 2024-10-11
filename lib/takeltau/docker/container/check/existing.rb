# frozen_string_literal: true

# takeltau docker container check existing
# tau docker container check existing
module DockerContainerCheckExisting
  # Backend method for docker container check existing.
  # @return [Boolean] is container existing?
  def docker_container_check_existing(container)
    log.debug "Checking if container \"#{container}\" is existing"

    return false unless docker_check_daemon

    stdout_str = run _docker_container_cmd_check_existing container

    if stdout_str.to_s.chomp.empty?
      log.debug "Container \"#{container}\" is not existing"
      return false
    end

    log.debug "Container \"#{container}\" is existing"
    true
  end

  private

  # Format command to check if docker container exists.
  def _docker_container_cmd_check_existing(container)
    format(
      config.active['cmd_docker_container_check_existing_docker_ps'],
      container: container
    )
  end
end
