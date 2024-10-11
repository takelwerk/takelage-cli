# frozen_string_literal: true

# tau ship info lib
module ShipInfoLib
  private

  # Gather takelship information
  def _ship_info_lib_get_takelshipinfo
    log.debug 'Gathering takelship info'
    takelshipinfo = _ship_info_lib_get_info_from_file
    takelshipinfo = _ship_info_lib_get_info_from_docker if takelshipinfo.empty?
    return false if takelshipinfo.nil?

    takelshipinfo
  end

  # Read takelship info from file
  def _ship_info_lib_get_info_from_file
    log.debug 'Reading takelship info from file'
    ship_data_dir = config.active['ship_data_dir']
    yaml_file = format(
      config.active['ship_takelship_yml'],
      pwd: Dir.getwd,
      ship_data_dir: ship_data_dir
    )
    read_yaml_file(yaml_file) || {}
  end

  # Read takelship info from docker run
  def _ship_info_lib_get_info_from_docker
    log.debug 'Reading takelship info from takelship container'
    command = 'info'
    _parse_yaml _ship_container_lib_docker_nonprivileged(command) || {}
  end

  def _ship_info_lib_valid_project?(takelship, project)
    valid_project = false
    takelship_projects = takelship['projects']
    takelship_projects.each do |takelship_project|
      valid_project = true if project == takelship_project['name']
    end
    valid_project
  end
end
