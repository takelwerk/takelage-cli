# frozen_string_literal: true

# tau docker container list
module DockerContainerList
  # Backend method for docker container prune.
  def docker_container_list
    log.debug 'List docker containers'

    return false unless docker_check_daemon

    _docker_container_list_get_inventory.to_yaml
  end

  private

  # Get the current inventory
  def _docker_container_list_get_inventory
    inventory = _docker_container_list_new_inventory
    _docker_container_lib_get_containers.each do |container|
      name = _docker_container_lib_get_container_name_by_id container
      if docker_container_check_orphaned container
        inventory['login']['hosts'] << name
      else
        inventory['orphaned']['hosts'] << name
      end
    end
    inventory
  end

  # Create a new inventory
  def _docker_container_list_new_inventory
    {
      'login' => {
        'hosts' => []
      },
      'orphaned' => {
        'hosts' => []
      }
    }
  end
end
