# frozen_string_literal: true

module Takelage
  # takelage docker image
  class DockerImage < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckModule
    include DockerImageTagListModule
    include DockerImageTagLatestModule
    include DockerImageModule

    # Initialize takelage docker image
    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      @docker_user = config.active['docker_user']
      @docker_repo = config.active['docker_repo']
      @docker_registry = config.active['docker_registry']
    end

    desc 'check [COMMAND]', 'Check docker image'
    subcommand 'check', DockerImageCheck

    desc 'tag [COMMAND]', 'Handle docker image tags'
    subcommand 'tag', DockerImageTag

    #
    # docker image update
    #
    desc 'update', 'Get latest remote docker container'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Get latest remote docker container
    This command will download the latest remote version of the takelage docker container.
    When you start the environment the latest locally available container will be used.
    LONGDESC
    # Get latest remote docker container.
    def update
      exit docker_image_update
    end
  end
end
