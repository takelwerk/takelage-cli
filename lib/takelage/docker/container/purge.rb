# frozen_string_literal: true

# takelage docker container purge
module DockerContainerPurge
  # Backend method for docker container purge.
  def docker_container_purge
    log.debug 'Removing orphaned docker containers'

    return false unless docker_check_running

    networks = _docker_container_purge_kill_orphaned_containers
    _docker_container_lib_remove_networks networks
  end

  private

  # Kill orphaned docker containers and return list of networks
  def _docker_container_purge_kill_orphaned_containers
    networks = []

    _docker_container_lib_get_containers.each do |container|
      next unless docker_container_check_orphaned container

      name = _docker_container_lib_get_container_name_by_id container
      _docker_container_lib_stop_container container
      networks << name unless networks.include? name
    end
    networks
  end
end
