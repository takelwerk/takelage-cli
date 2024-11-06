# frozen_string_literal: true

# tau ship container stop
module ShipContainerStop
  # Stop a takelship container
  def ship_container_stop
    _ship_container_stop_docker_stop
    "Stopped takelship #{_ship_container_lib_ship_hostname}"
  end

  private

  # Run takelship docker stop command
  def _ship_container_stop_docker_stop
    return false unless ship_container_check_existing

    cmd_docker_stop_command = format(
      config.active['cmd_ship_docker_stop'],
      ship_docker: config.active['cmd_ship_docker'],
      ship_hostname: _ship_container_lib_ship_hostname
    )
    run cmd_docker_stop_command
  end
end
