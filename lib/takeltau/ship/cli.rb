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
      super

      log.debug 'Check docker dameon for ship subcommand'
      exit false unless docker_check_daemon 'cmd_ship_docker', 'cmd_ship_docker_check'
    end

    desc 'completion [COMMAND] ', 'Print shell completion code'
    subcommand 'completion', ShipCompletion

    desc 'container [COMMAND]', 'Manage takelship containers'
    subcommand 'container', ShipContainer

    desc 'info [COMMAND]', 'Get info about takelship containers'
    subcommand 'info', ShipInfo

    desc 'ports [COMMAND]', 'Manage takelship ports'
    subcommand 'ports', ShipPorts

    desc 'project [COMMAND]', 'Manage takelship projects'
    subcommand 'project', ShipProject

    #
    # Top-level ship commands
    #

    desc 'board', 'Log in to a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Log in to a takelship as root.
    Alias for ship container login.
    LONGDESC
    # ship board: {Takeltau::ShipContainer#login}
    def board
      Takeltau::ShipContainer.new.login
    end

    desc 'clean', 'Stop all takelships'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Stop all takelship containers.
    Alias for ship container clean.
    LONGDESC
    # ship clean: {Takeltau::ShipProject#clean}
    def clean
      Takeltau::ShipContainer.new.clean
    end

    desc 'command [CMD]', 'Run a bash command in a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run a command in a takelship container as user podman.
    Alias for ship container command.
    LONGDESC
    # ship command: {Takeltau::ShipContainer#command}
    def command(*args)
      Takeltau::ShipContainer.new.command(*args)
    end

    desc 'docker [CMD]', 'Run a podman command in a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run a podman command as user podman in a takelship container.
    Alias for ship container podman.
    LONGDESC
    # ship docker: {Takeltau::ShipContainer#podman}
    def docker(*args)
      Takeltau::ShipContainer.new.podman(*args)
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

    desc 'login', 'Log in to a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Log in to a takelship as root.
    Alias for ship container login.
    LONGDESC
    # ship login: {Takeltau::ShipContainer#login}
    def login
      Takeltau::ShipContainer.new.login
    end

    desc 'logs [ARGS]', 'Print the takelship logs'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print the takelship logs.
    Alias for ship container logs.
    LONGDESC
    # ship logs: {Takeltau::ShipContainer#logs}
    def logs(*args)
      Takeltau::ShipContainer.new.logs(*args)
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

    desc 'podman [CMD]', 'Run a podman command in a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run a podman command as user podman in a takelship container.
    Alias for ship container podman.
    LONGDESC
    # ship podman: {Takeltau::ShipContainer#podman}
    def podman(*args)
      Takeltau::ShipContainer.new.podman(*args)
    end

    desc 'restart [PROJECT]', 'Restart a takelship [PROJECT]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Restart a takelship and run project [PROJECT] in it.
    Alias for ship project restart which is an
    alias for ship project stop and then ship project start.
    LONGDESC
    # ship restart: {Takeltau::ShipProject#restart}
    def restart(project = 'default')
      Takeltau::ShipProject.new.restart project
    end

    desc 'sudo [CMD]', 'Run a sudo command in a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run a command as root in a takelship container.
    Alias for ship container sudo.
    LONGDESC
    # ship sudo: {Takeltau::ShipContainer#sudo}
    def sudo(*args)
      Takeltau::ShipContainer.new.sudo(*args)
    end

    desc 'start [PROJECT]', 'Start a takelship [PROJECT]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Start a takelship and run project [PROJECT] in it.
    Alias for ship project start.
    LONGDESC
    # ship start: {Takeltau::ShipProject#start}
    def start(project = 'default')
      Takeltau::ShipProject.new.start project
    end

    desc 'sail [PROJECT]', 'Start a takelship [PROJECT]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Start a takelship and run project [PROJECT] in it.
    Alias for ship project start.
    LONGDESC
    # ship sail: {Takeltau::ShipProject#start}
    def sail(project = 'default')
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

    desc 'version', 'Print ship version'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print ship semantic version number.
    Alias for ship info version.
    LONGDESC
    def version
      Takeltau::ShipInfo.new.version
    end

    desc 'wreck', 'Stop a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Stop a takelship container.
    Alias for ship container stop.
    LONGDESC
    # ship wreck: {Takeltau::ShipProject#stop}
    def wreck
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
