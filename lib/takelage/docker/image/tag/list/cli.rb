module Takelage

  # takelage docker image tag list
  class DockerImageTagList < SubCommandBase

    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckModule
    include DockerImageTagListModule

    # Initialize takelage docker image tag list
    def initialize(args = [], local_options = {}, configuration = {})

      # initialize thor parent class
      super args, local_options, configuration

      @docker_repo = config.active['docker_repo']
      @docker_image = config.active['docker_image']
      @docker_tagsurl = config.active['docker_tagsurl']
    end

    #
    # docker image tag list local
    #
    desc 'local', 'Print local docker image tags'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print local docker image tags
    LONGDESC
    # Print local docker image tags.
    def local
      say docker_image_tag_list_local
    end

    #
    # docker image tag list remote
    #
    desc 'remote', 'Print remote docker image tags'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print remote docker image tags
    LONGDESC
    # Print latest remote docker image tag.
    def remote
      say docker_image_tag_list_remote
    end
  end
end
