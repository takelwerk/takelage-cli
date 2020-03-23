# takelage docker image tag check module
module DockerImageTagCheckModule

  # Backend method for docker image check tag local.
  # @return [Boolean] does local docker image tag exist?
  def docker_image_tag_check_local(tag)
    log.debug "Check if local docker image tag \"#{tag}\" exists"

    exit false unless configured? %w(docker_repo docker_image)

    if tag.to_s.strip.empty?
      log.warn "No local docker image tag specified"
      return false
    end

    image = "#{@docker_repo}/#{@docker_image}:#{tag}"

    cmd_docker_images = 'docker images --quiet ' +
        image

    stdout_str, stderr_str, status = run_and_check cmd_docker_images

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

    exit false unless configured? %w(docker_repo docker_image docker_tagsurl)

    if tag .to_s.strip.empty?
      log.warn "No remote docker image tag specified"
      return false
    end

    image = "#{@docker_repo}/#{@docker_image}:#{tag}"

    tags = docker_image_tag_list_remote

    unless tags.include? tag
      log.debug "No remote docker image \"#{image}\" found"
      return false
    end

    log.debug "Found remote docker image \"#{image}\""
    true
  end
end
