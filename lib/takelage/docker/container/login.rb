# frozen_string_literal: true

# takelage docker container login
module DockerContainerLogin
  # Backend method for docker container login.
  def docker_container_login
    log.debug 'Logging in to docker container'

    return false unless docker_check_running

    docker_socket_start
    return false unless _docker_container_lib_create_net_and_ctr @hostname

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
end
