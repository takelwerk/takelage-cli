# frozen_string_literal: true

module Takelage
  # takelage docker image check
  class DockerImageCheck < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckRunning
    include DockerImageTagListRemote
    include DockerImageTagLatestRemote
    include DockerImageCheckOutdated

    # Initialize takelage docker image check
    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      @docker_user = config.active['docker_user']
      @docker_repo = config.active['docker_repo']
      @docker_registry = config.active['docker_registry']
      @docker_tag = config.active['docker_tag']
    end

    #
    # docker image check outdated
    #
    desc 'outdated', 'Check if a docker image is outdated'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if a docker image is outdated
    LONGDESC
    # Check if a docker image is outdated.
    def outdated
      outdated = docker_image_check_outdated @docker_tag
      say "Your takelage version \"#{@docker_tag}\" is outdated" if outdated
      exit outdated
    end
  end
end
