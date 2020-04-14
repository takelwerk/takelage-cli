# takelage docker check module
module DockerCheckModule

  # Backend method for docker check running.
  # @return [Boolean] is the docker daemon running?
  def docker_check_running
    return true if @docker_daemon_running

    log.debug "Check if the docker daemon is running"

    cmd_docker_info =
        config.active['cmd_docker_check_running_docker_info']

    status = try cmd_docker_info

    unless status.exitstatus.zero?
      log.error "The docker daemon is not running"
      return false
    end

    log.debug "The docker daemon is running"
    @docker_daemon_running = true
    true
  end
end
