# frozen_string_literal: true

module Takeltau
  # tau ship info
  class ShipPorts < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon
    include ShipContainerLib
    include ShipInfoLib
    include ShipPortsLib
    include ShipPortsList

    desc 'list [PROJECT]', 'Print takelship ports of a [PROJECT]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print the ports that a takelship project exposes.
    LONGDESC
    # ship list: {Takeltau::ShipPorts#list}
    def list(project = 'default')
      say (ship_ports_list project).to_yaml
    end
  end
end
