# frozen_string_literal: true

# tau docker container prune
module DockerContainerPrune
  # Backend method for docker container prune.
  def docker_container_prune
    log.debug 'Removing orphaned docker containers'

    networks = _docker_container_prune_kill_orphaned_containers
    _docker_container_lib_remove_networks networks
  end

  private

  # Kill orphaned docker containers and return list of networks.
  def _docker_container_prune_kill_orphaned_containers
    networks = []

    _docker_container_lib_get_containers.each do |container|
      next unless docker_container_check_orphaned container

      name = _docker_container_lib_get_container_name_by_id container
      mutagen_socket_terminate "--label-selector='hostname=#{name}'"
      _docker_container_lib_stop_container container
      networks << name unless networks.include? name
    end
    networks
  end
end
