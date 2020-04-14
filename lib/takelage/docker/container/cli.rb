module Takelage

  # takelage docker container
  class DockerContainer < SubCommandBase

    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckModule
    include DockerContainerCheckModule
    include DockerContainerModule
    include DockerImageTagLatestModule
    include DockerImageTagListModule
    include DockerImageTagCheckModule
    include DockerImageCheckModule
    include DockerSocketModule

    # Initialize docker container
    def initialize(args=[], local_options={}, configuration={})

      # initialize thor parent class
      super args, local_options, configuration

      @docker_debug = config.active['docker_debug']

      @docker_user = config.active['docker_user']
      @docker_repo = config.active['docker_repo']
      @docker_tag = config.active['docker_tag']

      @entrypoint_options = config.active['docker_entrypoint_options']

      @dockersock = '/var/run/docker.sock'

      @username = ENV['USER'] ? ENV['USER'] : 'username'
      @gid = Etc.getpwnam(@username).gid
      @uid = Etc.getpwnam(@username).uid

      @homedir = ENV['HOME'] ? ENV['HOME'] : '/tmp'
      @workdir = Dir.getwd
      @hostname = "#{@docker_repo}_#{File.basename(@workdir)}"

      @timezone = 'Europe/Berlin'

      @socket_host = docker_socket_host
      @sockets = docker_socket_scheme
    end

    desc 'check [COMMAND]', 'Check docker container'
    subcommand 'check', DockerContainerCheck

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
           :aliases => 'd',
           :type => :boolean,
           :default => false,
           :desc => 'Log in to docker container in debug mode'
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
    # docker container purge
    #
    desc 'purge', 'Remove orphaned docker containers'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Remove orphaned docker containers
    LONGDESC
    # Remove orphaned docker containers.
    def purge
      docker_container_purge
    end

    #
    # docker container run
    #
    desc 'command [CMD]', 'Run [CMD] in a docker container'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run command in docker container
    LONGDESC
    # Run command in docker container.
    def command(command)
      docker_container_command(command)
    end
  end
end
