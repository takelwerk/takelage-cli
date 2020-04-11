# takelage docker container module
module DockerContainerModule

  # Backend method for docker container run.
  def docker_container_command(command)
    log.debug "Running command in container"

    return false unless docker_check_running

    return false unless configured? %w(docker_repo docker_image docker_tag)

    docker_socket_start

    _create_network @hostname unless docker_container_check_network @hostname
    _create_container @hostname unless docker_container_check_existing @hostname
    _run_command_in_container @hostname, command
  end

  # Backend method for docker container daemon.
  def docker_container_daemon
    log.debug 'Starting docker container as daemon'

    return false unless docker_check_running

    return false unless configured? %w(docker_repo docker_image docker_tag)

    _create_network @hostname unless docker_container_check_network @hostname
    _create_container @hostname unless docker_container_check_existing @hostname
  end

  # Backend method for docker container login.
  def docker_container_login
    log.debug 'Logging in to docker container'

    return false unless docker_check_running

    return false unless configured? %w(docker_repo docker_image docker_tag)

    docker_socket_start

    _create_network @hostname unless docker_container_check_network @hostname
    _create_container @hostname unless docker_container_check_existing @hostname
    _enter_container @hostname
  end

  # Backend method for docker container nuke.
  def docker_container_nuke
    log.debug 'Removing all docker containers'

    return false unless docker_check_running

    return false unless configured? %w(docker_image)

    networks = []

    _get_containers.each do |container|
      name = _get_container_name_by_id container
      _stop_container container
      networks << name unless networks.include? name
    end

    networks.each do |network|
      _remove_network network if docker_container_check_network network
    end
  end

  # Backend method for docker container purge.
  def docker_container_purge
    log.debug 'Removing orphaned docker containers'

    return false unless docker_check_running

    return false unless configured? %w(docker_image)

    networks = []

    _get_containers.each do |container|
      if docker_container_check_orphaned container
        name = _get_container_name_by_id container
        _stop_container container
        networks << name unless networks.include? name
      end
    end

    networks.each do |network|
      _remove_network network if docker_container_check_network network
    end
  end

  # Create docker container.
  def _create_container(container)
    log.debug "Creating container \"#{container}\""

    if docker_image_tag_list_local.include? @docker_tag
      tag = @docker_tag
    else
      tag = docker_image_tag_latest_local
    end

    image = "#{@docker_repo}/#{@docker_image}:#{tag}"

    log.debug "Using docker image \"#{image}\""

    unless docker_image_tag_check_local tag
      log.error "Image \"#{image}\" does not exist"
      return false
    end

    entrypoint = '/entrypoint.py '
    volume_dev = ''
    if options[:development]
      entrypoint = '/debug/entrypoint.py --debug '
      volume_dev = "--volume #{@workdir}/#{@docker_debug}:/debug "
    end

    cmd_docker_create =
        config.active['docker_create'] % {
            workdir: @workdir,
            timezone: @timezone,
            container: container,
            dockersock: @dockersock,
            homedir: @homedir,
            volume_dev: volume_dev,
            image: image,
            entrypoint: entrypoint,
            gid: @gid,
            uid: @uid,
            username: @username
        }

    run cmd_docker_create
  end

  # Create docker network.
  def _create_network(network)
    log.debug "Create network \"#{network}\""

    cmd_create_network =
        config.active['docker_create_network'] % {
            network: network
        }

    run cmd_create_network
  end

  # Enter existing docker container.
  def _enter_container(container)
    log.debug "Entering container \"#{container}\""

    loginpoint = '/loginpoint.py '
    if options[:development]
      loginpoint = '/loginpoint.py --debug '
    end

    cmd_docker_enter =
        config.active['docker_enter'] % {
            container: container,
            loginpoint: loginpoint,
            username: @username
        }

    run_and_exit cmd_docker_enter
  end

  # Get container name by id.
  def _get_container_name_by_id container
    log.debug "Getting name of container \"#{container}\""

    cmd_get_container_name_by_id =
        config.active['docker_get_container_name_by_id'] % {
            container: container
        }

    stdout_str = run cmd_get_container_name_by_id

    name = stdout_str.chomp

    log.debug "Container #{container} has name \"#{name}\""

    name
  end

  # Get all docker containers.
  # @return [Array] list of docker containers
  def _get_containers
    log.debug "Getting all containers of image \"#{@docker_image}\""

    cmd_docker_get =
        config.active['docker_get'] % {
            docker_image: @docker_image
        }

    stdout_str = run cmd_docker_get

    # convert stdout lines to array and return array
    stdout_str.split(/\n+/)
  end

  # Remove docker network.
  def _remove_network network
    log.debug "Remove network \"#{network}\""

    cmd_remove_network =
        config.active['docker_remove_network'] % {
            network: network
        }

    run cmd_remove_network
  end

  # Enter existing docker container.
  def _run_command_in_container(container, command)
    log.debug "Running command \"#{command}\" in container \"#{container}\""

    cmd_docker_run_command =
        config.active['docker_run_command'] % {
            container: container,
            username: @username,
            command: command
        }

    run_and_exit cmd_docker_run_command
  end

  # Stop container.
  def _stop_container(container)
    log.debug "Stopping container \"#{container}\""

    cmd_docker_stop =
        config.active['docker_stop'] % {
            container: container
        }

    run cmd_docker_stop
  end
end
