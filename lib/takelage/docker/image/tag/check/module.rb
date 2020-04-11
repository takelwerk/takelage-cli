# takelage docker image tag check module
module DockerImageTagCheckModule

  # Backend method for docker image check tag local.
  # @return [Boolean] does local docker image tag exist?
  def docker_image_tag_check_local(tag)
    log.debug "Check if local docker image tag \"#{tag}\" exists"

    return false unless docker_check_running

    return false unless configured? %w(docker_user docker_repo)

    if tag.to_s.strip.empty?
      log.warn "No local docker image tag specified"
      return false
    end

    image = "#{@docker_user}/#{@docker_repo}:#{tag}"

    cmd_docker_images =
        config.active['docker_images'] % {
            image: image
        }

    stdout_str = run cmd_docker_images

    if stdout_str.to_s.strip.empty?
      log.debug "No local docker image \"#{image}\" found"
      return false
    end

    log.debug "Found local docker image \"#{image}\""
    true
  end

  # Backend method for docker image check tag remote.
  # @return [Boolean] does remote docker image tag exist?
  def docker_image_tag_check_remote(tag)
    log.debug "Check if remote image tag \"#{tag}\" exists"

    return false unless docker_check_running

    return false unless configured? %w(docker_user docker_repo docker_tagsurl)

    if tag .to_s.strip.empty?
      log.warn "No remote docker image tag specified"
      return false
    end

    image = "#{@docker_user}/#{@docker_repo}:#{tag}"

    tags = docker_image_tag_list_remote

    unless tags.include? tag
      log.debug "No remote docker image \"#{image}\" found"
      return false
    end

    log.debug "Found remote docker image \"#{image}\""
    true
  end
end
