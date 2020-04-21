# frozen_string_literal: true

# takelage docker image tag latest module
module DockerImageTagLatestModule
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

  # Backend method for docker image tag latest remote.
  # @return [String] latest remote docker image tag
  def docker_image_tag_latest_remote
    log.debug 'Getting latest remote docker image tag'

    return false unless docker_check_running

    tags = docker_image_tag_list_remote

    if tags == false or tags.nil?
      log.warn 'No latest docker remote tag'
      return ''
    end

    tag_latest_remote = tags[-1]

    log.debug "Latest docker remote tag: #{tag_latest_remote}"

    tag_latest_remote
  end
end
