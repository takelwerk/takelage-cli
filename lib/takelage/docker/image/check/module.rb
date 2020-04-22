# frozen_string_literal: true

# takelage docker image check module
module DockerImageCheckModule
  # Backend method for docker image check outdated.
  # @return [Boolean] is docker image tag older than latest remote image tag?
  # rubocop:disable Style/RedundantSort
  def docker_image_check_outdated(tag)
    log.debug "Check if docker image version \"#{tag}\" is outdated"

    return false unless docker_check_running

    return false if _docker_outdated_tag_latest? tag

    tag_latest_remote = docker_image_tag_latest_remote
    tags = [tag, docker_image_tag_latest_remote]
    outdated = (tag != VersionSorter.sort(tags).last)

    _docker_outdated_log_info tag, tag_latest_remote if outdated

    outdated
  end

  # rubocop:enable Style/RedundantSort

  private

  # Check if the tag is "latest".
  def _docker_outdated_tag_latest?(tag)
    return false unless tag == 'latest'

    log.debug 'Docker image version "latest" is by definition never outdated'
    true
  end

  # Log info if docker image is outdated.
  def _docker_outdated_log_info(tag, tag_latest_remote)
    log.debug "Docker image version is outdated: #{tag}"
    log.debug "Docker image version is available: #{tag_latest_remote}"
  end
end
