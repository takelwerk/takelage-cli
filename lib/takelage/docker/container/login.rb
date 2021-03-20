# frozen_string_literal: true

# takelage docker container login
module DockerContainerLogin
  # Backend method for docker container login.
  def docker_container_login
    log.debug 'Logging in to docker container'

    return false unless docker_check_daemon

    return false unless _docker_container_lib_create_net_and_ctr @hostname

    _docker_container_lib_start_sockets

    _docker_container_wait_for_sockets

    run_and_exit _docker_container_login_enter_container @hostname
  end

  private

  # Prepare enter existing container command.
  def _docker_container_login_enter_container(container)
    log.debug "Entering container \"#{container}\""

    loginpoint = '/loginpoint.py'
    loginpoint = '/debug/loginpoint.py --debug ' if options[:debug]

    format(
      config.active['cmd_docker_container_enter_container'],
      container: container,
      loginpoint: loginpoint,
      username: @username
    )
  end

  # Wait for the sockets to come up
  def _docker_container_wait_for_sockets
    wait_for_sockets = config.active['login_wait_for_sockets'].to_i
    return if wait_for_sockets.zero?

    log.debug "Waiting for #{wait_for_sockets} #{pluralize(wait_for_sockets, 'second', 'seconds')}"
    sleep wait_for_sockets
  end
end
