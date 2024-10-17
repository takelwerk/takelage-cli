# frozen_string_literal: true

# tau ship project logs
module ShipProjectLogs
  # Start a takelship
  def ship_project_logs(project)
    return unless ship_container_check_existing

    takelship = _ship_info_lib_get_takelshipinfo
    project = _ship_info_lib_get_project(project, takelship)

    return false unless _ship_info_lib_valid_project? takelship, project

    log.debug "Following logs of takelship project \"#{project}\""
    _ship_project_logs_follow_logs project
  end

  private

  def _ship_project_logs_follow_logs(project)
    cmd_follow_logs = format(
      config.active['cmd_ship_project_follow_logs'],
      project: project
    )
    _ship_container_lib_docker_exec cmd_follow_logs
  end
end
