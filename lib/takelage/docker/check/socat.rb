# frozen_string_literal: true

# takelage docker check running
module DockerCheckSocat
  # Backend method for docker check socat.
  # @return [Boolean] is the socat command available?
  def docker_check_socat
    return true if @socat_command_available

    log.debug 'Check if the socat command is available'

    status = try config.active['cmd_docker_check_socat_which_socat']

    unless status.exitstatus.zero?
      log.error 'The socat command is not available'
      return false
    end

    log.debug 'The socat command is available'
    @socat_command_available = true
    true
  end
end
