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

    desc 'command [ARGS]', 'Run a command in a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run a command in a takelship container as user podman.
    Alias for ship container command.
    LONGDESC
    # ship command: {Takeltau::ShipContainer#command}
    def command(*args)
      Takeltau::ShipContainer.new.command args
    end

    desc 'list', 'List takelships'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    List takelship containers.
    Alias for ship container list.
    LONGDESC
    # ship list: {Takeltau::ShipContainer#list}
    def list
      Takeltau::ShipContainer.new.list
    end

    desc 'logs [PROJECT]', 'Follow logs of takelship project [PROJECT]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Follow logs of project [PROJECT] in a takelship project.
    Alias for ship project logs.
    LONGDESC
    # ship logs: {Takeltau::ShipProject#logs}
    def logs(project = 'default')
      Takeltau::ShipProject.new.logs(project)
    end

    desc 'ls', 'List takelships'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    List takelship containers.
    Alias for ship container list.
    LONGDESC
    # ship list: {Takeltau::ShipContainer#list}
    def ls
      Takeltau::ShipContainer.new.list
    end

    desc 'login', 'Log in to a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Log in to a takelship as root.
    Alias for ship container login.
    LONGDESC
    # ship login: {Takeltau::ShipContainer#login}
    def login
      Takeltau::ShipContainer.new.login
    end

    desc 'podman [ARGS]', 'Run a podman command in a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run a podman command as user podman in a takelship container.
    Alias for ship container podman.
    LONGDESC
    # ship podman: {Takeltau::ShipContainer#podman}
    def podman(*args)
      Takeltau::ShipContainer.new.podman args
    end

    desc 'sudo [ARGS]', 'Run a sudo command in a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run a command as root in a takelship container.
    Alias for ship container sudo.
    LONGDESC
    # ship sudo: {Takeltau::ShipContainer#sudo}
    def sudo(*args)
      Takeltau::ShipContainer.new.sudo args
    end

    desc 'start [PROJECT]', 'Start takelship project [PROJECT]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Start a takelship and run project [PROJECT] in it.
    Alias for ship project start.
    LONGDESC
    # ship start: {Takeltau::ShipProject#start}
    def start(project = 'default')
      Takeltau::ShipProject.new.start project
    end

    desc 'stop', 'Stop a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Stop a takelship container.
    Alias for ship container stop.
    LONGDESC
    # ship stop: {Takeltau::ShipProject#stop}
    def stop
      Takeltau::ShipProject.new.stop
    end

    desc 'update', 'Update takelship image'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Update the takelship docker image.
    Alias for ship container update.
    LONGDESC
    # tau update: {Takeltau::ShipContainer#update}
    def update
      Takeltau::ShipContainer.new.update
    end
  end
end
