# frozen_string_literal: true

# takelage docker image tag list remote
module DockerImageTagListRemote
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
