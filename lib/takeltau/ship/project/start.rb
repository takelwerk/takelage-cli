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

    log.debug "Starting takelship project \"#{project}\""
    ports = _ship_project_start_ports takelship, project
    say _ship_container_lib_docker_privileged ports, project
  end

  private

  # Get takelship ports
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def _ship_project_start_ports(takelship, project)
    ports = []
    takelship['projects'].each do |takelship_project|
      next unless project == takelship_project['name']

      takelship_project['services'].each do |service|
        next unless service.key?('ports')

        service['ports'].each do |port|
          ports << port['port']
        end
      end
    end
    if config.active['ship_port_expose_podman_socket'] == 'true'
      log.debug "Add DOCKER_HOST port #{config.active['ship_docker_host']}"
      ports << config.active['ship_docker_host']
    end
    ports
  end
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
