# frozen_string_literal: true

module Takelage
  # takelage docker image tag check
  class DockerImageTagCheck < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckRunning
    include DockerImageTagListModule
    include DockerImageTagCheckModule

    # Initialize takelage docker image tag check
    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      @docker_user = config.active['docker_user']
      @docker_repo = config.active['docker_repo']
      @docker_registry = config.active['docker_registry']
    end

    #
    # docker image tag check local
    #
    desc 'local [TAG]', 'Check if local docker image [TAG] exists'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if local docker image tag exists
    LONGDESC
    # Check if local docker image tag exists.
    def local(tag)
      exit docker_image_tag_check_local tag
    end

    #
    # docker image tag check remote
    #
    desc 'remote [TAG]', 'Check if remote docker image [TAG] exists'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if remote docker image tag exists
    LONGDESC
    # Check if remote docker image tag exists.
    def remote(tag)
      exit docker_image_tag_check_remote tag
    end
  end
end
