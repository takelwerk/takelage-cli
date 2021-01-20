# frozen_string_literal: true

# takelage docker image tag list
module DockerImageTagList
  # Backend method for docker image tag list.
  # @return [Array] docker image tags
  def docker_image_tag_list
    cmd_docker_tags =
      format(
        config.active['cmd_docker_image_tag_list_docker_images'],
        docker_user: @docker_user,
        docker_repo: @docker_repo
      )

    tags = (run cmd_docker_tags).split("\n")

    VersionSorter.sort(tags)
  end
end
