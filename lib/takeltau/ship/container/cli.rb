# frozen_string_literal: true

module Takeltau
  # tau docker container
  class ShipContainer < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerContainerLib
    include ShipInfoLib
    include ShipContainerCheckExisting
    include ShipContainerLib
    include ShipContainerClean
    include ShipContainerList
    include ShipContainerLogin
    include ShipContainerPodman
    include ShipContainerCommand
    include ShipContainerSudo
    include ShipContainerStop
    include ShipContainerUpdate

    desc 'check [COMMAND]', 'Check takelship containers'
    subcommand 'check', ShipContainerCheck

    #
    # ship container clean
    #
    desc 'clean', 'Stop all takelships'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Stop all takelship containers.
    LONGDESC
    def clean
      ship_container_clean
    end

    #
    # ship container command
    #
    desc 'command [COMMAND]', 'Run a [COMMAND] in a takelship container'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run a command in a takelship container as user podman.
    LONGDESC
    def command(*args)
      say ship_container_command args
    end

    #
    # ship container list
    #
    desc 'list', 'List takelships'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    List takelship containers.
    LONGDESC
    def list
      say ship_container_list
    end

    #
    # ship container login
    #
    desc 'login', 'Log in to a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Log in to a takelship as root.
    LONGDESC
    def login
      ship_container_login
    end

    #
    # ship container podman
    #
    desc 'podman [COMMAND]', 'Run a podman [COMMAND] in a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run a podman command as user podman in a takelship container.
    LONGDESC
    def podman(*args)
      say ship_container_podman args
    end

    #
    # ship container sudo
    #
    desc 'sudo [COMMAND]', 'Run a sudo [COMMAND] in a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run a command as root in a takelship container.
    LONGDESC
    def sudo(*args)
      say ship_container_sudo args
    end

    #
    # ship container stop
    #
    desc 'stop', 'Stop a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Stop a takelship container.
    LONGDESC
    def stop
      ship_container_stop
    end

    #
    # ship container update
    #
    desc 'update', 'Update takelship image'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Update the takelship docker image.
    LONGDESC
    def update
      ship_container_update
    end
  end
end
