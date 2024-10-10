# frozen_string_literal: true

module Takeltau
  # tau ship
  class Ship < SubCommandBase
    desc 'container [COMMAND]', 'Manage takelship containers'
    subcommand 'container', ShipContainer

    desc 'info [COMMAND]', 'Get info about takelship containers'
    subcommand 'info', ShipInfo

    desc 'project [COMMAND]', 'Manage takelship projects'
    subcommand 'project', ShipProject

    #
    # Top-level ship commands
    #

    desc 'default', 'Start project default in a takelship container'
    # ship default: {Takeltau::ShipProject#default}
    def default
      Takeltau::ShipProject.new.default
    end

    desc 'podman', 'Run login command in a takelship container'
    # ship login: {Takeltau::ShipContainer#login}
    def login
      Takeltau::ShipContainer.new.login
    end

    desc 'podman [ARGS]', 'Run podman command in a takelship container'
    # ship podman: {Takeltau::ShipContainer#podman}
    def podman(*args)
      Takeltau::ShipContainer.new.podman args
    end

    desc 'start [PROJECT]', 'Start project [PROJECT] in a takelship container'
    # ship start: {Takeltau::ShipProject#start}
    def start(project)
      Takeltau::ShipProject.new.start project
    end

    desc 'stop', 'Stop a takelship container'
    # ship stop: {Takeltau::ShipProject#stop}
    def stop
      Takeltau::ShipProject.new.stop
    end
  end
end
