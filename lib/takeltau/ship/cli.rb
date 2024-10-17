# frozen_string_literal: true

module Takeltau
  # tau ship
  class Ship < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon

    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      log.debug 'Check docker dameon for ship subcommand'
      exit false unless docker_check_daemon 'cmd_ship_docker', 'cmd_ship_docker_check'
    end

    desc 'completion [COMMAND] ', 'Print shell completion code'
    subcommand 'completion', ShipCompletion

    desc 'container [COMMAND]', 'Manage takelship containers'
    subcommand 'container', ShipContainer

    desc 'info [COMMAND]', 'Get info about takelship containers'
    subcommand 'info', ShipInfo

    desc 'project [COMMAND]', 'Manage takelship projects'
    subcommand 'project', ShipProject

    #
    # Top-level ship commands
    #

    desc 'list', 'Alias for tau ship container list'
    # ship list: {Takeltau::ShipContainer#list}
    def list
      Takeltau::ShipContainer.new.list
    end

    desc 'logs [PROJECT]', 'Alias for tau ship project logs'
    # ship logs: {Takeltau::ShipProject#logs}
    def logs(project = 'default')
      Takeltau::ShipProject.new.logs(project)
    end

    desc 'ls', 'Alias for tau ship container list'
    # ship list: {Takeltau::ShipContainer#list}
    def ls
      Takeltau::ShipContainer.new.list
    end

    desc 'login', 'Alias for tau ship container login'
    # ship login: {Takeltau::ShipContainer#login}
    def login
      Takeltau::ShipContainer.new.login
    end

    desc 'podman [ARGS]', 'Alias for tau ship container podman'
    # ship podman: {Takeltau::ShipContainer#podman}
    def podman(*args)
      Takeltau::ShipContainer.new.podman args
    end

    desc 'start [PROJECT]', 'Alias for tau ship project start'
    # ship start: {Takeltau::ShipProject#start}
    def start(project = 'default')
      Takeltau::ShipProject.new.start project
    end

    desc 'stop', 'Alias for tau ship project stop'
    # ship stop: {Takeltau::ShipProject#stop}
    def stop
      Takeltau::ShipProject.new.stop
    end

    desc 'update', 'Alias for tau ship container update'
    # tau update: {Takeltau::ShipContainer#update}
    def update
      Takeltau::ShipContainer.new.update
    end
  end
end
