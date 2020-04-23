# frozen_string_literal: true

# takelage docker image tag check remote
module DockerImageTagCheckRemote
  # Backend method for docker image check tag remote.
  # @return [Boolean] does remote docker image tag exist?
  def docker_image_tag_check_remote(tag)
    log.debug "Check if remote image tag \"#{tag}\" exists"

    return false unless docker_check_running

    if tag.to_s.strip.empty?
      log.warn 'No remote docker image tag specified'
      return false
    end

    image = "#{@docker_user}/#{@docker_repo}:#{tag}"

    return false unless _docker_iamge_check_remote_image? image, tag

    log.debug "Found remote docker image \"#{image}\""
    true
  end

  private

  # Check if remote image exists.
  def _docker_iamge_check_remote_image?(image, tag)
    tags = docker_image_tag_list_remote

    unless tags != false && tags.include?(tag)
      log.debug "No remote docker image \"#{image}\" found"
      return false
    end

    true
  end
end
