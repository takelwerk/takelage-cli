# frozen_string_literal: true

# tau ship ports list
module ShipPortsList
  # List takelship portss.
  def ship_ports_list(project)
    log.debug 'List takelship ports'

    takelship = _ship_info_lib_get_takelshipinfo
    project = _ship_info_lib_get_project(project, takelship)

    return false unless _ship_info_lib_valid_project? takelship, project

    _ship_ports_lib_get_ports takelship, project
  end
end
