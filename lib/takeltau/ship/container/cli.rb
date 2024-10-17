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

    desc 'check [COMMAND]', 'Check takelship container'
    subcommand 'check', ShipContainerCheck

    #
    # ship container clean
    #
    desc 'clean', 'Stop all takelship containers'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Stop all takelship containers
    LONGDESC
    # Stop all takelship containers.
    def clean
      ship_container_clean
    end

    #
    # ship container command
    #
    desc 'command', 'Run a command in a takelship container'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run a command in a takelship container
    LONGDESC
    # Run a command in a takelship container.
    def command(*args)
      say ship_container_command args
    end

    #
    # ship container list
    #
    desc 'list', 'List takelship containers'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    List takelage containers
    LONGDESC
    # List takelage containers.
    def list
      say ship_container_list
    end

    #
    # ship container login
    #
    desc 'login', 'Log in to a takelship'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Log in to a takelship
    LONGDESC
    # Log in to a takelship.
    def login
      ship_container_login
    end

    #
    # ship container podman
    #
    desc 'podman', 'Run podman command'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run podman command
    LONGDESC
    # Run podman command.
    def podman(*args)
      say ship_container_podman args
    end

    #
    # ship container sudo
    #
    desc 'sudo', 'Run a sudo command in a takelship container'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Run a sudo command in a takelship container
    LONGDESC
    # Run a sudo command in a takelship container.
    def sudo(*args)
      say ship_container_sudo args
    end

    #
    # ship container stop
    #
    desc 'stop', 'Stop takelship container'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Stop takelship container
    LONGDESC
    # Stop takelship container.
    def stop
      ship_container_stop
    end

    #
    # ship container update
    #
    desc 'update', 'Update takelship image'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Update takelship image
    LONGDESC
    # Update takelship image.
    def update
      ship_container_update
    end
  end
end
