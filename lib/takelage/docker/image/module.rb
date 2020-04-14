# takelage docker image module
module DockerImageModule

  # Backend method for docker image update.
  def docker_image_update
    return false unless docker_check_running

    tag_latest_remote = docker_image_tag_latest_remote

    if tag_latest_remote.to_s.strip.empty?
      log.error "Unable to get latest remote tag"
      return false
    end

    tag_latest_local = docker_image_tag_latest_local

    unless tag_latest_local.to_s.strip.empty?
      begin
        if Gem::Version.new(tag_latest_local) >= Gem::Version.new(tag_latest_remote)
          log.info 'Already up to date.'
          return false
        end
      rescue ArgumentError
        log.debug "Cannot compare \"#{tag_latest_local}\" and \"#{tag_latest_remote}\""
      end
    end

    log.info "Updating to docker image \"#{@docker_user}/#{@docker_repo}:#{tag_latest_remote}\""

    cmd_docker_pull_latest =
        config.active['cmd_docker_image_update_docker_pull_latest'] % {
            docker_user: @docker_user,
            docker_repo: @docker_repo,
            tag_latest_remote: tag_latest_remote
        }

    run_and_exit cmd_docker_pull_latest
  end
end
