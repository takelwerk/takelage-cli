# frozen_string_literal: true

module Takeltau
  # tau docker container
  class DockerContainer < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon
    include DockerContainerCheckExisting
    include DockerContainerCheckNetwork
    include DockerContainerCheckOrphaned
    include DockerContainerLib
    include DockerContainerCommand
    include DockerContainerDaemon
    include DockerContainerLogin
    include DockerContainerClean
    include DockerContainerPrune
    include DockerImageTagLatest
    include DockerImageTagList
    include DockerImageTagCheck
    include MutagenCheckDaemon
    include MutagenSocketCheck
    include MutagenSocketCreate
    include MutagenSocketTerminate

    # Initialize docker container
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      @docker_user = config.active['docker_user']
      @docker_repo = config.active['docker_repo']
      @docker_tag = config.active['docker_tag']
      @docker_registry = config.active['docker_registry']
      @username = ENV['USER'] || 'noname'
      @workdir = Dir.getwd
      @hostname = _docker_container_lib_hostname
      @hostlabel = "hostname=#{@hostname}"
      @takellabel = config.active['mutagen_socket_takelage_label']
      @mutagensock_container = config.active['mutagen_socket_path_mutagen_container']
      @mutagensock_host = config.active['mutagen_socket_path_mutagen_host']
      @gpgsock_container = config.active['mutagen_socket_path_gpg_container']
      @gpgsock_host = config.active['mutagen_socket_path_gpg_host']
      @sshsock_container = config.active['mutagen_socket_path_ssh_container']
      @sshsock_host = config.active['mutagen_socket_path_ssh_host']
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize

    desc 'check [COMMAND]', 'Check docker container'
    subcommand 'check', DockerContainerCheck

    #
    # docker container clean
    #
    desc 'clean', 'Remove all docker containers'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Remove all docker containers
    LONGDESC
    # Remove all docker containers.
    def clean
      docker_container_clean
    end

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
    option :debug,
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
