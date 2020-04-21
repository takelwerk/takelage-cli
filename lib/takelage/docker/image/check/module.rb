# frozen_string_literal: true

# takelage docker image check module
module DockerImageCheckModule
  # Backend method for docker image check outdated.
  # @return [Boolean] is docker image tag older than latest remote docker image tag?
  def docker_image_check_outdated(tag)
    log.debug "Check if docker image version \"#{tag}\" is outdated"

    return false unless docker_check_running

    if tag == 'latest'
      log.debug 'Docker image version "latest" is by definition never outdated'
      return false
    end

    tag_latest_remote = docker_image_tag_latest_remote
    tags = [tag, tag_latest_remote]
    outdated = tag != VersionSorter.sort(tags).last

    if outdated
      "Docker image version \"#{tag}\" is outdated"
      "Docker image version \"#{tag_latest_remote}\" is available"
    end

    outdated
  end
end
