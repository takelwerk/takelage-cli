# frozen_string_literal: true

# tau docker image uppdate
module DockerImageUpdate
  # Backend method for docker image update.
  def docker_image_update
    return false unless docker_check_daemon

    cmd_docker_pull = _docker_image_update_cmd_docker_pull

    cmd_docker_remove_dangling =
      config.active['cmd_docker_image_update_docker_remove_dangling']

    run_and_exit "#{cmd_docker_pull} && #{cmd_docker_remove_dangling}"
  end

  private

  # Prepare dpcker pull latest command.
  def _docker_image_update_cmd_docker_pull
    format(
      config.active['cmd_docker_image_update_docker_pull'],
      docker_user: @docker_user,
      docker_repo: @docker_repo,
      docker_tag: @docker_tag
    )
  end
end
