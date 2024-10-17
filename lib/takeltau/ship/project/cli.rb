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
    include ShipProjectList
    include ShipProjectLogs
    include ShipProjectStart

    #
    # ship container list
    #
    desc 'list', 'List projects'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    List projects
    LONGDESC
    # List projects.
    def list
      ship_project_list
    end

    #
    # ship container logs
    #
    desc 'logs [PROJECT]', 'Follow logs of project [PROJECT]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Follow logs of project [PROJECT]
    LONGDESC
    # logs projects.
    def logs(project = 'default')
      ship_project_logs project
    end

    #
    # ship container start
    #
    desc 'start [PROJECT]', 'Start project [PROJECT] in a takelship container'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Start project [PROJECT] in a takelship container
    LONGDESC
    # Run command in docker container.
    def start(project = 'default')
      ship_project_start project
    end

    #
    # ship project stop
    #
    desc 'stop', 'Stop a takelship container'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Stop a takelship container
    LONGDESC
    # Stop a takelship container.
    def stop
      say ship_container_stop
    end
  end
end
