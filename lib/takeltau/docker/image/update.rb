# frozen_string_literal: true

# tau docker image update
module DockerImageUpdate
  # Backend method for docker image update.
  def docker_image_update
    cmd_docker_pull = _docker_image_update_cmd_docker_pull

    cmd_docker_remove_dangling = format(
      config.active['cmd_docker_image_update_docker_remove_dangling'],
      docker: config.active['cmd_docker']
    )

    run_and_exit "#{cmd_docker_pull} && #{cmd_docker_remove_dangling}"
  end

  private

  # Prepare dpcker pull latest command.
  def _docker_image_update_cmd_docker_pull
    format(
      config.active['cmd_docker_image_update_docker_pull'],
      docker: config.active['cmd_docker'],
      docker_user: @docker_user,
      docker_repo: @docker_repo,
      docker_tag: @docker_tag
    )
  end
end
