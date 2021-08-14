# frozen_string_literal: true

# takeltau docker image tag latest
module DockerImageTagLatest
  # Backend method for docker image tag latest.
  # @return [String] latest docker image tag
  def docker_image_tag_latest
    log.debug 'Getting latest docker image tag'

    return false unless docker_check_daemon

    tags = docker_image_tag_list

    tag_latest = if tags.include? 'latest'
                   'latest'
                 else
                   tags[-1]
                 end

    log.debug "Latest docker tag: #{tag_latest}"

    tag_latest
  end
end
