# frozen_string_literal: true

module Takelage
  # takelage mutagen socket
  class MutagenSocket < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon
    include DockerCheckSocat
    include DockerContainerCheckExisting
    include DockerContainerCheckNetwork
    include DockerContainerCommand
    include DockerContainerLib
    include DockerSocketLib
    include DockerSocketScheme
    include DockerSocketStart
    include MutagenSocketCheck
    include MutagenSocketCreate
    include MutagenSocketList
    include MutagenSocketTerminate

    # Initialize mtagen socket
    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      @docker_repo = config.active['docker_repo']
      @username = ENV['USER'] || 'noname'
      @workdir = Dir.getwd
      inside = _docker_container_lib_check_matrjoschka
      @hostname = inside ? ENV['HOSTNAME'] : _docker_container_lib_hostname
      @hostlabel = "hostname=#{@hostname}"
      @takellabel = 'type=takelage-socket'
      @sockets = docker_socket_scheme
    end

    #
    # mutagen socket check
    #
    desc 'check [SOCKET]', 'Check if mutagen [SOCKET] exists'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if mutagen [SOCKET] exists
    LONGDESC
    # Check if mutagen [SOCKET] exists.
    def check(socket)
      exit mutagen_socket_check socket
    end

    #
    # mutagen socket create
    #
    desc 'create [IN] [OUT]', 'Create a mutagen socket from [IN] to [OUT] of the container'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Create a mutagen socket from [IN] to [OUT] of the container
    LONGDESC
    # Create a mutagen socket from [IN] to [OUT] of the container.
    def create(containersock, hostsock)
      exit mutagen_socket_create containersock, hostsock
    end

    #
    # mutagen socket list
    #
    desc 'list', 'List mutagen sockets'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    List mutagen sockets
    LONGDESC
    # List mutagen sockets.
    def list
      socket_list = mutagen_socket_list
      exit false if socket_list == false
      say socket_list
      true
    end

    #
    # mutagen socket terminate
    #
    desc 'terminate', 'Terminate a mutagen socket'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Terminate a mutagen socket
    LONGDESC
    # Terminate a mutagen socket.
    def terminate(socket)
      exit mutagen_socket_terminate socket
    end
  end
end