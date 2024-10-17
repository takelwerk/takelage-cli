# frozen_string_literal: true

# tau ship container login
module ShipContainerLogin
  # Run a login command in a takelship
  def ship_container_login
    return false unless ship_container_check_existing

    command_after_login = config.active['cmd_ship_container_login']
    _ship_container_lib_docker_exec command_after_login, '--tty'
  end
end
