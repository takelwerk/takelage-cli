# frozen_string_literal: true

# tau ship project restart
module ShipProjectRestart
  # Restart a takelship
  def ship_project_restart(project)
    say ship_container_stop
    _ship_project_restart_wait
    ship_project_start project
  end

  private

  # Wait until a takelship container is stopped
  def _ship_project_restart_wait
    cmd_ship_docker_wait = format(
      config.active['cmd_ship_docker_wait'],
      ship_docker: config.active['cmd_ship_docker'],
      ship_hostname: _ship_container_lib_ship_hostname
    )

    run cmd_ship_docker_wait
  end
end
