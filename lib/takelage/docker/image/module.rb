# takelage docker image module
module DockerImageModule

  # Backend method for docker image update.
  def docker_image_update
    return false unless docker_check_running

    tags_remote = docker_image_tag_list_remote

    if tags_remote.include? 'latest'
      tag = 'latest'
    else
      tag = docker_image_tag_latest_remote
    end

    cmd_docker_pull_latest =
        config.active['cmd_docker_image_update_docker_pull_latest'] % {
            docker_user: @docker_user,
            docker_repo: @docker_repo,
            tag_latest_remote: tag
        }

    cmd_docker_remove_dangling =
        config.active['cmd_docker_image_update_docker_remove_dangling']

    run_and_exit "#{cmd_docker_pull_latest} && #{cmd_docker_remove_dangling}"
  end
end