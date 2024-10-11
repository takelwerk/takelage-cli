# frozen_string_literal: true

# tau ship container update
module ShipContainerUpdate
  # Update takelship image.
  def ship_container_update
    return false unless docker_check_daemon

    cmd_docker_pull = _ship_container_update_cmd_docker_pull

    cmd_docker_remove_dangling =
      config.active['cmd_docker_image_update_docker_remove_dangling']
    run_and_exit "#{cmd_docker_pull} && #{cmd_docker_remove_dangling}"
  end

  private

  # Prepare dpcker pull latest command.
  def _ship_container_update_cmd_docker_pull
    ship_user = config.active['ship_user']
    ship_repo = config.active['ship_repo']
    ship_tag = config.active['ship_tag']
    format(
      config.active['cmd_docker_image_update_docker_pull'],
      docker_user: ship_user,
      docker_repo: ship_repo,
      docker_tag: ship_tag
    )
  end
end
