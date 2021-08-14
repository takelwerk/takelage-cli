# frozen_string_literal: true

# takeltau docker image tag check
module DockerImageTagCheck
  # Backend method for docker image tag check.
  # @return [Boolean] does docker image tag exist?
  def docker_image_tag_check(tag)
    log.debug "Check if docker image tag \"#{tag}\" exists"

    return false unless docker_check_daemon

    if tag.to_s.chomp.empty?
      log.warn 'No docker image tag specified'
      return false
    end

    image = "#{@docker_user}/#{@docker_repo}:#{tag}"

    return false unless _docker_image_check_image? image

    log.debug "Found docker image \"#{image}\""
    true
  end

  private

  # Check if image exists.
  def _docker_image_check_image?(image)
    cmd_docker_images =
      format(
        config.active['cmd_docker_image_tag_check_docker_images'],
        image: image
      )

    if (run cmd_docker_images).to_s.chomp.empty?
      log.debug "No docker image \"#{image}\" found"
      return false
    end

    true
  end
end
