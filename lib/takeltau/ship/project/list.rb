# frozen_string_literal: true

# tau ship project list
module ShipProjectList
  # List takelship projects
  def ship_project_list
    log.debug 'List takelship projects'
    takelship = _ship_info_lib_get_takelshipinfo
    unless takelship.instance_of?(Hash)
      say 'Could not get takelship info'
      say 'Try: ship update'
      say 'Try: ship list --debug'
      return false
    end

    unless takelship.key?('projects')
      say 'Could not get takelship projects'
      say 'Try: ship update'
      say 'Try: ship list --debug'
      return false
    end

    takelship['projects'].each do |project|
      say project['name']
    end
  end
end
