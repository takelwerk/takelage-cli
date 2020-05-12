# frozen_string_literal: true

# takelage docker container clean
module DockerContainerClean
  # Backend method for docker container clean.
  def docker_container_clean
    log.debug 'Removing all docker containers'

    return false unless docker_check_running

    return false if _docker_container_clean_harakiri?

    networks = _docker_container_clean_kill_existing_containers
    _docker_container_lib_remove_networks networks
  end

  private

  # Check if we are running tau clean inside a takelage container
  def _docker_container_clean_harakiri?
    hostname = ENV['HOSTNAME'] || ''
    return false unless hostname.start_with? "#{@docker_repo}_"

    log.error "Please run \"tau clean\" outside of #{@docker_repo} containers"
    log.info "Run \"tau prune\" to remove orphaned #{@docker_repo} containers"
    true
  end

  # Kill all docker containers and return list of networks
  def _docker_container_clean_kill_existing_containers
    networks = []
    _docker_container_lib_get_containers.each do |container|
      name = _docker_container_lib_get_container_name_by_id container
      _docker_container_lib_stop_container container
      networks << name unless networks.include? name
    end
    networks
  end
end
