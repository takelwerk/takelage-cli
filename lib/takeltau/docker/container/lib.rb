# frozen_string_literal: true

# tau docker container lib
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Style/IfUnlessModifier
module DockerContainerLib
  private

  # Create mutagen sockets
  def _docker_container_lib_start_sockets
    return false unless mutagen_check_daemon

    mutagen_socket_create 'mutagen', @mutagensock, @mutagensock
    mutagen_socket_create 'gpg', @gpgsock, @gpgsock
    mutagen_socket_create 'ssh', @sshsock, @sshsock
  end

  # Create unique docker hostname
  def _docker_container_lib_hostname
    relative_name = "#{@docker_repo}_#{File.basename(@workdir)}"
    absolute_name = "#{@docker_repo}_#{@workdir}"
    digest = Digest::SHA256.bubblebabble absolute_name
    "#{relative_name}_#{digest[0..10]}"
  end

  # Create docker container and network.
  def _docker_container_lib_create_net_and_ctr(name)
    return true if docker_container_check_existing name

    unless docker_container_check_network name
      _docker_container_lib_create_network name
    end

    _docker_container_lib_create_container name
  end

  # Remove docker networks.
  def _docker_container_lib_remove_networks(networks)
    networks.each do |network|
      if docker_container_check_network network
        _docker_container_lib_remove_network network
      end
    end
  end

  # Create docker network.
  def _docker_container_lib_create_network(network)
    log.debug "Create network \"#{network}\""

    cmd_create_network = format(
      config.active['cmd_docker_container_create_network'],
      network: network
    )

    run cmd_create_network
  end

  # Remove docker network.
  def _docker_container_lib_remove_network(network)
    log.debug "Remove network \"#{network}\""

    cmd_remove_network = format(
      config.active['cmd_docker_container_remove_network'],
      network: network
    )

    run cmd_remove_network
  end

  # Create docker container.
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def _docker_container_lib_create_container(container)
    log.debug "Creating container \"#{container}\""

    image = "#{@docker_user}/#{@docker_repo}:#{@docker_tag}"

    return false unless _docker_container_lib_image_available? image

    log.debug "Using docker image \"#{image}\""

    docker_debug = config.active['docker_debug']
    entrypoint = '/entrypoint.py '
    volume_dev = ''
    if options[:debug]
      entrypoint = '/debug/entrypoint.py --debug '
      volume_dev = "--volume #{@workdir}/#{docker_debug}:/debug "
    end

    cmd_docker_create = format(
      config.active['cmd_docker_container_create'],
      container: container,
      docker_run_options: config.active['docker_run_options'],
      dockersock: '/var/run/docker.sock',
      entrypoint: entrypoint,
      entrypoint_options: config.active['docker_entrypoint_options'],
      extra: config.active['docker_entrypoint_extra'],
      gid: Etc.getpwnam(@username).gid,
      homedir: ENV['HOME'] || '/tmp',
      image: image,
      shmsize: config.active['docker_shm_size'],
      timezone: 'Europe/Berlin',
      uid: Etc.getpwnam(@username).uid,
      username: @username,
      volume_dev: volume_dev,
      workdir: @workdir
    )

    try cmd_docker_create
  end

  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  # Check if we are already inside a takelage container
  def _docker_container_lib_check_matrjoschka
    log.debug 'Checking if we are already inside a takelage container'

    unless ENV.keys.include? 'TAKELAGE_PROJECT_BASE_DIR'
      log.debug 'We are not inside a takelage container'
      return false
    end

    log.debug 'We are inside a takelage container'

    true
  end

  # Check if docker image is available
  def _docker_container_lib_image_available?(image)
    return true if docker_image_tag_list.include? @docker_tag

    log.error "No local image \"#{image}\" available"
    log.info "Try: docker pull #{image}"
    false
  end

  # Get container name by id.
  def _docker_container_lib_get_container_name_by_id(container)
    log.debug "Getting name of container \"#{container}\""

    cmd_get_container_name_by_id = format(
      config.active['cmd_docker_container_get_container_name'],
      container: container
    )

    name = (run cmd_get_container_name_by_id).chomp

    log.debug "Container #{container} has name \"#{name}\""

    name
  end

  # Get all docker containers.
  # @return [Array] list of docker containers
  def _docker_container_lib_get_containers
    log.debug "Getting all containers of image \"#{@docker_repo}\""

    cmd_docker_get = format(
      config.active['cmd_docker_container_get_containers'],
      docker_repo: @docker_repo
    )

    # convert stdout lines to array and return array
    (run cmd_docker_get).split(/\n+/)
  end

  # Stop container.
  def _docker_container_lib_stop_container(container)
    log.debug "Stopping container \"#{container}\""

    cmd_docker_stop = format(
      config.active['cmd_docker_container_stop_container'],
      container: container
    )

    run cmd_docker_stop
  end
end
# rubocop:enable Style/IfUnlessModifier
# rubocop:enable Metrics/ModuleLength
