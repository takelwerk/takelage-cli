# frozen_string_literal: true

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

      @docker_user = config.active['docker_user']
      @docker_repo = config.active['docker_repo']
      @docker_registry = config.active['docker_registry']
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
      tag_list_local = docker_image_tag_list_local
      exit false if tag_list_local == false
      say tag_list_local
      true
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
      tag_list_remote = docker_image_tag_list_remote
      exit false if tag_list_remote == false
      say tag_list_remote
      true
    end
  end
end
