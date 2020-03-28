module Takelage

  # takelage docker container check
  class DockerContainerCheck < SubCommandBase

    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerContainerCheckModule

    #
    # docker container check existing
    #
    desc 'existing [CONTAINER]', 'Check if docker [CONTAINER] is existing'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if docker container is existing
    This check looks for a container with a given name.
    If such a container is existing the result is true else false.
    LONGDESC
    # Check if docker container is existing.
    def existing(container)
      exit docker_container_check_existing container
    end

    #
    # docker container check network
    #
    desc 'network [NETWORK]', 'Check if docker [NETWORK] is existing'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if docker network is existing
    This check looks for a network with a given name.
    If such a network is existing the result is true else false.
    LONGDESC
    # Check if docker network is existing.
    def network(network)
      exit docker_container_check_network network
    end

    #
    # docker container check orphaned
    #
    desc 'orphaned [CONTAINER]', 'Check if docker [CONTAINER] is orphaned'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if docker container is orphaned
    This check looks for a process which is started
    when you log in to an takelage docker container.
    If such a process is found the result is true else false.
    LONGDESC
    # Check if docker container is orphaned.
    def orphaned(container)
      exit docker_container_check_orphaned container
    end
  end
end
