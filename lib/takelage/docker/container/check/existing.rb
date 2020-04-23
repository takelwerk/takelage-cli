# frozen_string_literal: true

# takelage docker container check existing
module DockerContainerCheckExisting
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

  private

  def _docker_container_cmd_check_existing(container)
    format(
      config.active['cmd_docker_container_check_existing_docker_ps'],
      container: container
    )
  end
end
