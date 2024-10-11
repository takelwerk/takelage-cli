# frozen_string_literal: true

# tau ship project start
module ShipProjectStart
  # Start a takelship
  def ship_project_start(project)
    return false unless docker_check_daemon

    return false if _docker_container_lib_check_matrjoschka

    return false if ship_container_check_existing

    takelship = _ship_info_lib_get_takelshipinfo
    project = config.active['ship_default_project'] if project == 'default'
    project = takelship['default_project'] if project == 'default'

    return false unless _ship_info_lib_valid_project? takelship, project

    log.debug "Starting takelship project \"#{project}\""
    ports = _ship_project_start_ports takelship, project
    say _ship_container_lib_docker_privileged ports, project
  end

  private

  # Get takelship ports
  # rubocop:disable Metrics/MethodLength
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
    # add DOCKER_HOST port
    ports << config.active['ship_docker_host']
    ports
  end
end
# rubocop:enable Metrics/MethodLength
