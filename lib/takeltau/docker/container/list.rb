# frozen_string_literal: true

# tau docker container list
module DockerContainerList
  # Backend method for docker container prune.
  def docker_container_list
    log.debug 'List docker containers'

    return false unless docker_check_daemon

    _docker_container_list_list_docker_containers
  end

  private

  # Kill orphaned docker containers and return list of networks.
  def _docker_container_list_list_docker_containers
    containers_login = []
    containers_orphaned = []
    _docker_container_lib_get_containers.each do |container|
      name = _docker_container_lib_get_container_name_by_id container
      if docker_container_check_orphaned container
        containers_login << name
      else
        containers_orphaned << name
      end
    end

    inventory = {
      "login" => {
        "hosts" => []
      },
      "orphaned" => {
        "hosts" => []
      }
    }

    for container_name in containers_login do
      inventory['login']['hosts'] << container_name
    end
    for container_name in containers_orphaned do
      inventory['orphaned']['hosts'] << container_name
    end

    inventory.to_yaml()
  end
end
