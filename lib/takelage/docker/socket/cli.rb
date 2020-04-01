module Takelage

  # takelage docker socket
  class DockerSocket < SubCommandBase

    include LoggingModule
    include ConfigModule
    include SystemModule
    include DockerCheckModule
    include DockerSocketModule

    # Initialize docker socket
    def initialize(args = [], local_options = {}, configuration = {})

      # initialize thor parent class
      super args, local_options, configuration

      @sockets = {
          :'agent-socket' => {
              :path => nil,
              :host => '127.0.0.1',
              :port => config.active['docker_socket_agent_port']},
          :'agent-ssh-socket' => {
              :path => nil,
              :host => '127.0.0.1',
              :port => config.active['docker_socket_agent_ssh_port']},
          :'agent-extra-socket' => {
              :path => nil,
              :host => '127.0.0.1',
              :port => config.active['docker_socket_agent_extra_port']},
          :'agent-browser-socket' => {
              :path => nil,
              :host => '127.0.0.1',
              :port => config.active['docker_socket_agent_browser_port']}}
      _get_socket_paths
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
