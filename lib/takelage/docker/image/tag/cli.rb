# frozen_string_literal: true

module Takelage
  # takelage docker image tag
  class DockerImageTag < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon
    include DockerImageTagList
    include DockerImageTagList
    include DockerImageTagLatest
    include DockerImageTagCheck

    # Initialize takelage docker image tag check
    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      @docker_user = config.active['docker_user']
      @docker_repo = config.active['docker_repo']
      @docker_registry = config.active['docker_registry']
    end

    #
    # docker image tag check
    #
    desc 'check [TAG]', 'Check if docker image [TAG] exists'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if docker image tag exists
    LONGDESC
    # Check if docker image tag exists.
    def check(tag)
      exit docker_image_tag_check tag
    end

    #
    # docker image tag latest
    #
    desc 'latest', 'Print latest docker image tag'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print latest docker image tag
    Print the tag of the docker image with the highest tag.
    LONGDESC
    # Print latest docker image tag.
    def latest
      tag_latest = docker_image_tag_latest
      exit false if tag_latest == false
      say tag_latest
      true
    end

    #
    # docker image tag list
    #
    desc 'list', 'Print docker image tags'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print docker image tags
    LONGDESC
    # Print docker image tags.
    def list
      tag_list = docker_image_tag_list
      exit false if tag_list == false
      say tag_list
      true
    end
  end
end
