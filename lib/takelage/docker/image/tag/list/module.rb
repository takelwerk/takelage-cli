# frozen_string_literal: true

# takelage docker image tag list module
module DockerImageTagListModule
  # Backend method for docker image tag list local.
  # @return [Array] local docker image tags
  def docker_image_tag_list_local
    cmd_docker_tags =
      format(
        config.active['cmd_docker_image_tag_list_local_docker_images'],
        docker_user: @docker_user,
        docker_repo: @docker_repo
      )

    tags = (run cmd_docker_tags).split("\n")

    VersionSorter.sort(tags)
  end

  # Backend method for docker image tag list remote.
  # @return [Array] remote docker image tags
  def docker_image_tag_list_remote
    log.debug 'Getting docker remote tags ' \
      "of \"#{@docker_user}/#{@docker_repo}\" " \
      "from \"#{@docker_registry}\""
    _docker_image_tag_list_remote_tags
  end

  private

  # Get docker remote tags.
  def _docker_image_tag_list_remote_tags
    user = File.basename @docker_user
    begin
      registry = DockerRegistry2.connect(@docker_registry)
      tags = registry.tags("#{user}/#{@docker_repo}")
      VersionSorter.sort(tags['tags'])
    rescue RestClient::Exceptions::OpenTimeout
      log.error "Timeout while connecting to \"#{@docker_registry}\""
      false
    end
  end
end
