# frozen_string_literal: true

module Takelage
  # takelage docker container
  class DockerContainer < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckRunning
    include DockerContainerCheckExisting
    include DockerContainerCheckNetwork
    include DockerContainerCheckOrphaned
    include DockerContainerLib
    include DockerContainerCommand
    include DockerContainerDaemon
    include DockerContainerLogin
    include DockerContainerNuke
    include DockerContainerPrune
    include DockerImageTagLatestLocal
    include DockerImageTagListLocal
    include DockerImageTagCheckLocal
    include DockerImageCheckOutdated
    include DockerSocketLib
    include DockerSocketHost
    include DockerSocketScheme
    include DockerSocketStart

    # Initialize docker container
    # rubocop:disable Metrics/AbcSize
    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      @docker_user = config.active['docker_user']
      @docker_repo = config.active['docker_repo']
      @docker_tag = config.active['docker_tag']
      @docker_registry = config.active['docker_registry']
      @username = ENV['USER'] || 'noname'
      @workdir = Dir.getwd
      @hostname = "#{@docker_repo}_#{File.basename(@workdir)}"
      @socket_host = docker_socket_host
      @sockets = docker_socket_scheme
    end
    # rubocop:enable Metrics/AbcSize

    desc 'check [COMMAND]', 'Check docker container'
    subcommand 'check', DockerContainerCheck

    #
    # docker container command
    #
    desc 'command [CMD]', 'Run [CMD] in a docker container'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run command in docker container
    LONGDESC
    # Run command in docker container.
    def command(command)
      docker_container_command(command)
    end

    #
    # docker container daemon
    #
    desc 'daemon', 'Run docker container in daemon mode'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run docker container in daemon mode
    LONGDESC
    # Run docker container in daemon mode.
    def daemon
      docker_container_daemon
    end

    #
    # docker container login
    #
    option :development,
           aliases: 'd',
           type: :boolean,
           default: false,
           desc: 'Log in to docker container in debug mode'
    desc 'login', 'Log in to latest local docker container'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Log in to latest local docker container
    LONGDESC
    # Log in to latest local docker container.
    def login
      docker_container_login
    end

    #
    # docker container nuke
    #
    desc 'nuke', 'Remove all docker containers'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Remove all docker containers
    LONGDESC
    # Remove all docker containers.
    def nuke
      docker_container_nuke
    end

    #
    # docker container prune
    #
    desc 'prune', 'Remove orphaned docker containers'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Remove orphaned docker containers
    LONGDESC
    # Remove orphaned docker containers.
    def prune
      docker_container_prune
    end
  end
end
