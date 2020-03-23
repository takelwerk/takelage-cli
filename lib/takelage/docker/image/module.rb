# takelage docker image module
module DockerImageModule

  # Backend method for docker image update.
  def docker_image_update
    exit false unless configured? %w(docker_repo docker_image docker_tagsurl)

    tag_latest_local = docker_image_tag_latest_local

    if tag_latest_local.to_s.strip.empty?
      log.error "Unable to get latest local tag"
      exit false
    end

    tag_latest_remote = docker_image_tag_latest_remote

    if tag_latest_remote.to_s.strip.empty?
      log.error "Unable to get latest remote tag"
      exit false
    end

    if Gem::Version.new(tag_latest_local) >= Gem::Version.new(tag_latest_remote)
      log.info 'Already up to date.'
      exit
    end

    cmd_docker_pull_latest = "docker pull #{@docker_repo}/#{@docker_image}:#{tag_latest_remote}"

    log.info "Updating to docker image \"#{@docker_repo}/#{@docker_image}:#{tag_latest_remote}\""

    run_and_exit cmd_docker_pull_latest
  end
end
