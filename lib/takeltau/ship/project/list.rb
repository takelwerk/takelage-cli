# frozen_string_literal: true

# tau ship project list
module ShipProjectList
  # List takelship projects
  def ship_project_list
    log.debug 'List takelship projects'
    _ship_info_lib_get_takelshipinfo['projects'].each do |project|
      say project['name']
    end
  end
end

