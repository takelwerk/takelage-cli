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
    include ShipProjectCreate
    include ShipProjectList
    include ShipProjectStart

    #
    # ship project dump
    #
    desc 'create [PROJECT]', 'Create a takelship [PROJECT]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Create a takelship [PROJECT].
    This command will create the configuration files of a takelship [PROJECT].
    It will neither run the [PROJECT] in a takelship nor create service data.
    LONGDESC
    def create(project = 'default')
      exit ship_project_create project
    end

    #
    # ship project list
    #
    desc 'list', 'List takelship projects'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    List all available takelship projects.
    LONGDESC
    def list
      ship_project_list
    end

    #
    # ship project restart
    #
    desc 'restart [PROJECT]', 'Restart a takelship [PROJECT]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Restart a takelship and run the project [PROJECT] in it.
    Alias for ship project stop and ship project start.
    LONGDESC
    # ship restart: {Takeltau::ShipProject#restart}
    def restart(project = 'default')
      Takeltau::ShipProject.new.stop
      Takeltau::ShipProject.new.start project
    end

    #
    # ship project start
    #
    desc 'start [PROJECT]', 'Start a takelship [PROJECT]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Start a takelship and run project [PROJECT] in it.
    LONGDESC
    def start(project = 'default')
      exit ship_project_start project
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

    #
    # ship project update
    #
    desc 'update [PROJECT]', 'Update a takelship [PROJECT]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Update a takelship [PROJECT].
    This command will update the configuration files of a takelship [PROJECT].
    It will neither run the [PROJECT] in a takelship nor touch the service data.
    LONGDESC
    def update(project = 'default')
      exit ship_project_create project, 'Updated'
    end
  end
end
