module Takelage

  # takelage docker image tag latest
  class DockerImageTagLatest < SubCommandBase

    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckModule
    include DockerImageTagListModule
    include DockerImageTagLatestModule

    # Initialize takelage docker image tag latest
    def initialize(args = [], local_options = {}, configuration = {})

      # initialize thor parent class
      super args, local_options, configuration

      @docker_repo = config.active['docker_repo']
      @docker_image = config.active['docker_image']
      @docker_tagsurl = config.active['docker_tagsurl']
    end

    #
    # docker image tag latest local
    #
    desc 'local', 'Print latest local docker image tag'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print latest local docker image tag
    Print the tag of the local docker image with the highest tag.
    LONGDESC
    # Print latest local docker image tag.
    def local
      tag_latest_local = docker_image_tag_latest_local
      exit false if tag_latest_local == false
      say tag_latest_local
      true
    end

    #
    # docker image tag latest remote
    #
    desc 'remote', 'Print latest remote docker image tag'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print latest remote docker image tag
    Print the tag of the remote docker image with the highest tag.
    LONGDESC
    # Print latest remote docker image tag.
    def remote
      tag_latest_remote = docker_image_tag_latest_remote
      exit false if tag_latest_remote == false
      say tag_latest_remote
      true
    end
  end
end
