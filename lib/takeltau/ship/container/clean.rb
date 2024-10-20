# frozen_string_literal: true

# tau ship container clean
module ShipContainerClean
  # Remove all takelship containers
  def ship_container_clean
    _ship_container_clean_remove_containers
  end

  private

  # Remove all takelship containers
  def _ship_container_clean_remove_containers
    ship_name = config.active['ship_name']
    log.debug "Getting all #{ship_name} containers"

    cmd_docker_get = format(
      config.active['cmd_docker_container_get_containers'],
      docker: config.active['cmd_docker'],
      docker_repo: ship_name
    )

    containers = (run cmd_docker_get).split(/\n+/)
    containers.each do |container|
      _ship_container_lib_remove_container container
    end
  end
end
