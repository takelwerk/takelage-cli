# frozen_string_literal: true

# tau ship project start
module ShipProjectStart
  # Start a takelship
  def ship_project_start(project)
    return false if _docker_container_lib_check_matrjoschka

    return false if ship_container_check_existing

    takelship = _ship_info_lib_get_takelshipinfo
    project = _ship_info_lib_get_project(project, takelship)

    return false unless _ship_info_lib_valid_project? takelship, project

    ports = _ship_ports_lib_get_ports(takelship, project)

    log.debug 'Writing port configuration to takelage.yml'
    _ship_ports_lib_write_ports(ports, project)

    log.debug "Starting takelship project \"#{project}\""
    say _ship_container_lib_docker_privileged ports, project
  end
end
