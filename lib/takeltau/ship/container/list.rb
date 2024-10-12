# frozen_string_literal: true

# tau ship container list
module ShipContainerList
  # List takelship containers.
  def ship_container_list
    log.debug 'List takelship containers'

    return false unless docker_check_daemon 'cmd_ship_docker'

    _ship_container_list_get_inventory.to_yaml
  end

  private

  # Get the current inventory
  def _ship_container_list_get_inventory
    ship_name = config.active['ship_name']
    inventory = _ship_container_list_new_inventory ship_name
    _ship_container_lib_get_containers.each do |container|
      name = _docker_container_lib_get_container_name_by_id container
      dir = _ship_container_lib_get_mounted_dir.strip
      inventory[ship_name]['hosts'] << { name => dir }
    end
    inventory
  end

  # Create a new inventory
  def _ship_container_list_new_inventory(ship_name)
    {
      ship_name => {
        'hosts' => []
      }
    }
  end
end
