# frozen_string_literal: true

module Takeltau
  # tau docker container
  class ShipProject < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon
    include ShipContainerCheckExisting
    include ShipContainerLib
    include ShipInfoLib
    include ShipProjectList
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
      say _ship_container_lib_docker_stop
    end
  end
end
