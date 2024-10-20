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
    project_root_dir = config.active['project_root_dir']
    ship_data_dir = config.active['ship_data_dir']
    args = []
    args << "--volume #{project_root_dir}/#{ship_data_dir}:/home/podman/takelship"
    args << '--env TAKELSHIP_DUMP=true'
    _ship_container_lib_docker_privileged ports, project, args.join(' ')
    "#{verb} takelship project \"#{project}\"."
  end
end
