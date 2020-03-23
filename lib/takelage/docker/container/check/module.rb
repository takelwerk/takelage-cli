# takelage docker container check module
module DockerContainerCheckModule

  # Backend method for docker container check existing.
  # @return [Boolean] is container existing?
  def docker_container_check_existing(container)
    log.debug "Checking if container \"#{container}\" is existing"

    cmd_docker_existing = 'docker ps ' +
        "--filter name=^#{container}$ " +
        '--quiet'

    stdout_str, stderr_str, status = run_and_check cmd_docker_existing

    if stdout_str.to_s.strip.empty?
      log.debug "Container \"#{container}\" is not existing"
      return false
    end

    log.debug "Container \"#{container}\" is existing"
    true
  end

  # Backend method for docker container check orphaned.
  # @return [Boolean] is container orphaned?
  def docker_container_check_orphaned(container)
    log.debug "Check if container \"#{container}\" is orphaned"

    cmd_docker_orphaned = 'docker exec ' +
        '--interactive ' +
        "#{container} " +
        'ps a'

    stdout_str, stderr_str, status = run_and_check cmd_docker_orphaned

    if stdout_str.include? '/loginpoint.py'
      log.debug "Container \"#{container}\" isn't orphaned"
      return false
    end

    log.debug "Container \"#{container}\" is orphaned"
    true
  end
end
