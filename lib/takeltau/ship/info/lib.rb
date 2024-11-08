# frozen_string_literal: true

# tau ship info lib
module ShipInfoLib
  private

  # Gather takelship information
  def _ship_info_lib_get_takelshipinfo
    log.debug 'Gathering takelship info'
    takelshipinfo = _ship_info_lib_get_info_from_docker
    return false if takelshipinfo.nil?

    takelshipinfo
  end

  # Read takelship info from docker run
  def _ship_info_lib_get_info_from_docker
    log.debug 'Reading takelship info from takelship container'
    command = 'info'
    _parse_yaml _ship_container_lib_docker_nonprivileged(command) || {}
  end

  def _ship_info_lib_get_project(project, takelship)
    return '' unless takelship.instance_of?(Hash)

    return '' unless takelship.key? 'default_project'

    project = config.active['ship_default_project'] if project == 'default'
    project = takelship['default_project'] if project == 'default'
    project
  end

  def _ship_info_lib_valid_project?(takelship, project)
    valid_project = false
    takelship_projects = takelship['projects']
    return false if takelship_projects.nil? || takelship_projects.empty?

    takelship_projects.each do |takelship_project|
      valid_project = true if project == takelship_project['name']
    end
    valid_project
  end
end
