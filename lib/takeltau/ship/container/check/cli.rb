# frozen_string_literal: true

module Takeltau
  # tau ship container check
  class ShipContainerCheck < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon
    include ShipContainerLib
    include ShipContainerCheckExisting

    #
    # ship container check existing
    #
    desc 'existing', 'Check if takelship is existing'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if a takelship container is existing
    This check looks for a container with a given name.
    If such a container is existing the result is true else false.
    LONGDESC
    # Check if takelship container is existing.
    def existing
      exit ship_container_check_existing
    end
  end
end
