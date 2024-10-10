# frozen_string_literal: true

module Takeltau
  # tau docker container
  class ShipContainer < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon
    include ShipInfoLib
    include ShipContainerCheckExisting
    include ShipContainerLib
    include ShipContainerLogin
    include ShipContainerPodman

    desc 'check [COMMAND]', 'Check takelship container'
    subcommand 'check', ShipContainerCheck

    #
    # ship container login
    #
    desc 'login', 'Run login command'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
      Run login command
    LONGDESC
    # Run login command.
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
      result = ship_container_podman args
      unless result
        say "No connection to takelship"
        exit 1
      end
      say result
    end
  end
end
