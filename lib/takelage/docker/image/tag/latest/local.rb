# frozen_string_literal: true

# takelage docker image tag latest local
module DockerImageTagLatestLocal
  # Backend method for docker image tag latest local.
  # @return [String] latest local docker image tag
  def docker_image_tag_latest_local
    log.debug 'Getting latest local docker image tag'

    return false unless docker_check_running

    tags = docker_image_tag_list_local

    tag_latest_local = tags[-1]

    log.debug "Latest docker local tag: #{tag_latest_local}"

    tag_latest_local
  end
end
