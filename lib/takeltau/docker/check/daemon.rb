# frozen_string_literal: true

# tau docker check daemon
module DockerCheckDaemon
  # Backend method for docker check daemon.
  # @return [Boolean] is the docker daemon running?
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def docker_check_daemon(docker = 'cmd_docker', docker_check = 'cmd_docker_check')
    return false unless command_available_else_error? config.active[docker_check]

    log.debug 'Check if the docker daemon is running'
    cmd_docker_info = format(
      config.active['cmd_docker_check_daemon_info'],
      docker: config.active[docker]
    )
    status = try cmd_docker_info

    unless status.exitstatus.zero?
      log.error 'The docker daemon is not running'
      return false
    end

    log.debug 'The docker daemon is running'
    true
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
