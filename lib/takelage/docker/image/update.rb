# frozen_string_literal: true

# takelage docker image uppdate
module DockerImageUpdate
  # Backend method for docker image update.
  def docker_image_update
    return false unless docker_check_running

    cmd_docker_pull_latest = _docker_image_update_cmd_docker_pull_latest

    cmd_docker_remove_dangling =
      config.active['cmd_docker_image_update_docker_remove_dangling']

    run_and_exit "#{cmd_docker_pull_latest} && #{cmd_docker_remove_dangling}"
  end

  private

  # Prepare dpcker pull latest command.
  def _docker_image_update_cmd_docker_pull_latest
    format(
      config.active['cmd_docker_image_update_docker_pull_latest'],
      docker_user: @docker_user,
      docker_repo: @docker_repo
    )
  end
end
