# frozen_string_literal: true

# takelage docker image check outdated
module DockerImageCheckOutdated
  # Backend method for docker image check outdated.
  # @return [Boolean] is docker image tag older than latest remote image tag?
  def docker_image_check_outdated(tag)
    log.debug "Check if docker image version \"#{tag}\" is outdated"

    return false unless docker_check_running

    return false if _docker_outdated_tag_latest? tag

    tag_latest_remote = docker_image_tag_latest_remote
    tags = [tag, docker_image_tag_latest_remote]
    # rubocop:disable Style/RedundantSort
    outdated = (tag != VersionSorter.sort(tags).last)
    # rubocop:enable Style/RedundantSort

    _docker_outdated_log_info tag, tag_latest_remote if outdated

    outdated
  end

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
