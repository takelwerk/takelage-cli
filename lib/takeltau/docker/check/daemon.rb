# frozen_string_literal: true

# tau docker check daemon
module DockerCheckDaemon
  # Backend method for docker check daemon.
  # @return [Boolean] is the docker daemon running?
  # rubocop:disable Metrics/MethodLength
  def docker_check_daemon
    return true if @docker_daemon_running

    return false unless command_available_else_error? config.active['cmd_docker']

    log.debug 'Check if the docker daemon is running'

    cmd_docker_info = format(
      config.active['cmd_docker_check_daemon_docker_info'],
      docker: config.active['cmd_docker']
    )
    status = try cmd_docker_info

    unless status.exitstatus.zero?
      log.error 'The docker daemon is not running'
      return false
    end

    log.debug 'The docker daemon is running'
    @docker_daemon_running = true
    true
  end
  # rubocop:enable Metrics/MethodLength
end
