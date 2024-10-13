# frozen_string_literal: true

module Takeltau
  # tau ship
  class Ship < SubCommandBase
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

    desc 'config', 'Alias for tau self config active'
    # tau config: {Takeltau::SelfConfig#active}
    def config
      Takeltau::SelfConfig.new.active
    end

    desc 'list', 'Alias for tau ship container list'
    # ship list: {Takeltau::ShipContainer#list}
    def list
      Takeltau::ShipContainer.new.list
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
