# frozen_string_literal: true

# tau ship project create
module ShipProjectCreate
  # Start a takelship
  def ship_project_create(project, verb = 'Created')
    takelship = _ship_info_lib_get_takelshipinfo
    project = _ship_info_lib_get_project project, takelship
    return false unless _ship_project_start_valid_project? takelship, project

    log.debug "Dumping takelship project \"#{project}\""
    ports = _ship_ports_lib_get_ports(takelship, project)

    ship_status = _ship_container_lib_docker_privileged(
      ports,
      project,
      ship_hostname_suffix: 'dump',
      publish_ports: false
    )
    return false unless _ship_container_lib_started? ship_status

    say "#{verb} takelship project \"#{project}\"."
    true
  end
end
