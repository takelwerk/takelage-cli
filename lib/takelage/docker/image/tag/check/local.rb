# frozen_string_literal: true

# takelage docker image tag check local
module DockerImageTagCheckLocal
  # Backend method for docker image check tag local.
  # @return [Boolean] does local docker image tag exist?
  def docker_image_tag_check_local(tag)
    log.debug "Check if local docker image tag \"#{tag}\" exists"

    return false unless docker_check_running

    if tag.to_s.strip.empty?
      log.warn 'No local docker image tag specified'
      return false
    end

    image = "#{@docker_user}/#{@docker_repo}:#{tag}"

    return false unless _docker_image_check_local_image? image

    log.debug "Found local docker image \"#{image}\""
    true
  end

  private

  # Check if local image exists.
  def _docker_image_check_local_image?(image)
    cmd_docker_images =
      format(
        config.active['cmd_docker_image_tag_check_local_docker_images'],
        image: image
      )

    if (run cmd_docker_images).to_s.strip.empty?
      log.debug "No local docker image \"#{image}\" found"
      return false
    end

    true
  end
end
