# frozen_string_literal: true

# takelage docker image tag list local
module DockerImageTagListLocal
  # Backend method for docker image tag list local.
  # @return [Array] local docker image tags
  def docker_image_tag_list_local
    cmd_docker_tags =
      format(
        config.active['cmd_docker_image_tag_list_local_docker_images'],
        docker_user: @docker_user,
        docker_repo: @docker_repo
      )

    tags = (run cmd_docker_tags).split("\n")

    VersionSorter.sort(tags)
  end
end
