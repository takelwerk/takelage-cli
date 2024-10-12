# frozen_string_literal: true

module Takeltau
  # tau docker container
  class ShipContainer < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon
    include DockerContainerLib
    include ShipInfoLib
    include ShipContainerCheckExisting
    include ShipContainerLib
    include ShipContainerList
    include ShipContainerLogin
    include ShipContainerPodman
    include ShipContainerUpdate

    desc 'check [COMMAND]', 'Check takelship container'
    subcommand 'check', ShipContainerCheck

    #
    # ship container list
    #
    desc 'list', 'list command'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
      Run list command
    LONGDESC
    # Run list command.
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
