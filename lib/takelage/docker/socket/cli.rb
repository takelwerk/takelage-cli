# frozen_string_literal: true

module Takelage
  # takelage docker socket
  class DockerSocket < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon
    include DockerCheckSocat
    include DockerSocketLib
    include DockerSocketHost
    include DockerSocketScheme
    include DockerSocketStart
    include DockerSocketStop

    # Initialize docker socket
    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      @socket_host = docker_socket_host
      @sockets = docker_socket_scheme
    end

    #
    # docker socket host
    #
    desc 'host', 'Print docker socket host ip address'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print docker socket host ip address
    LONGDESC
    # Print docker socket host ip address.
    def host
      say @socket_host
      true
    end

    #
    # docker socket scheme
    #
    desc 'scheme', 'Print docker socket scheme'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print docker socket scheme
    LONGDESC
    # Print docker socket scheme.
    def scheme
      say hash_to_yaml(@sockets)
      true
    end

    #
    # docker socket start
    #
    desc 'start', 'Start sockets for docker container'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Start sockets for docker container
    LONGDESC
    # Start sockets for docker container.
    def start
      exit docker_socket_start
    end

    #
    # docker socket stop
    #
    desc 'stop', 'Stop sockets for docker container'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Stop sockets for docker container
    LONGDESC
    # Stop sockets for docker container.
    def stop
      exit docker_socket_stop
    end
  end
end
