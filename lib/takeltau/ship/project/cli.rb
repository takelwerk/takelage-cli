# frozen_string_literal: true

module Takeltau
  # tau docker container
  class ShipProject < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon
    include DockerContainerLib
    include ShipContainerCheckExisting
    include ShipContainerLib
    include ShipContainerStop
    include ShipInfoLib
    include ShipPortsLib
    include ShipProjectList
    include ShipProjectLogs
    include ShipProjectStart

    #
    # ship container list
    #
    desc 'list', 'List takelship projects'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    List all available takelship projects.
    LONGDESC
    def list
      ship_project_list
    end

    #
    # ship container logs
    #
    desc 'logs [PROJECT]', 'Follow logs of [PROJECT]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Follow logs of project [PROJECT] in a takelship project.
    LONGDESC
    def logs(project = 'default')
      ship_project_logs project
    end

    #
    # ship container start
    #
    desc 'start [PROJECT]', 'Start takelship [PROJECT]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Start a takelship and run project [PROJECT] in it.
    LONGDESC
    def start(project = 'default')
      say ship_project_start project
    end

    #
    # ship project stop
    #
    desc 'stop', 'Stop a takelship project'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Stop a takelship container running a project.
    LONGDESC
    def stop
      say ship_container_stop
    end
  end
end
