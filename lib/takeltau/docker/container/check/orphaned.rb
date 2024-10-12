# frozen_string_literal: true

# tau docker container check orphaned
module DockerContainerCheckOrphaned
  # Backend method for docker container check orphaned.
  # @return [Boolean] is container orphaned?
  def docker_container_check_orphaned(container)
    log.debug "Check if container \"#{container}\" is orphaned"

    return false unless docker_check_daemon

    stdout_str = run _docker_container_cmd_check_orphaned container

    if stdout_str.include? '/loginpoint.py'
      log.debug "Container \"#{container}\" isn't orphaned"
      return false
    end

    log.debug "Container \"#{container}\" is orphaned"
    true
  end

  private

  # Format command to check if docker container is orphaned.
  def _docker_container_cmd_check_orphaned(container)
    format(
      config.active['cmd_docker_container_check_orphaned_docker_exec'],
      docker: config.active['cmd_docker'],
      container: container
    )
  end
end
