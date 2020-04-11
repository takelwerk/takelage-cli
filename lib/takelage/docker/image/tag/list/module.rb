# takelage docker image tag list module
module DockerImageTagListModule

  # Backend method for docker image tag list local.
  # @return [Array] local docker image tags
  def docker_image_tag_list_local
    tags = []

    cmd_docker_tags =
        config.active['docker_tags'] % {
            docker_repo: @docker_repo,
            docker_image: @docker_image
        }

    stdout_str = run cmd_docker_tags

    tags = stdout_str.split("\n")

    VersionSorter.sort(tags)
  end

  # Backend method for docker image tag list remote.
  # @return [Array] remote docker image tags
  def docker_image_tag_list_remote
    log.debug "Getting docker remote tags from \"#{@docker_tagsurl}\""

    begin
      @res = Net::HTTP.get_response URI(@docker_tagsurl)
      unless @res.code.eql? '200'
        log.error "Unable to connect to \"#{@docker_tagsurl}\""
        return false
      end
    rescue SocketError => e
      log.debug e
      return false
    end

    begin
      tags = JSON.parse @res.body
    rescue JSON::ParserError
      log.error 'Unable to parse JSON'
      return false
    end

    VersionSorter.sort(tags['tags'])
  end
end
