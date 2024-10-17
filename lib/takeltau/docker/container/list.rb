# frozen_string_literal: true

# tau docker container list
module DockerContainerList
  # List docker containers.
  def docker_container_list
    log.debug 'List docker containers'

    _docker_container_list_get_inventory.to_yaml
  end

  private

  # Get the current inventory
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def _docker_container_list_get_inventory
    destination = '/project'
    docker = config.active['cmd_docker']
    inventory = _docker_container_list_new_inventory
    _docker_container_lib_get_containers.each do |container|
      name = _docker_container_lib_get_container_name_by_id container
      dir = (_docker_container_lib_get_mounted_dir name, destination, docker).strip
      if docker_container_check_orphaned container
        inventory['orphaned']['hosts'] << { name => dir }
      else
        inventory['login']['hosts'] << { name => dir }
      end
    end
    inventory
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

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
