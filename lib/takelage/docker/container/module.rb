# takelage docker container module
module DockerContainerModule

  # Backend method for docker container run.
  def docker_container_command(command)
    log.debug "Running command in container"

    exit false unless configured? %w(docker_repo docker_image docker_tag)

    docker_socket_start

    _create_container @hostname unless docker_container_check_existing @hostname
    _run_command_in_container @hostname, command
  end

  # Backend method for docker container daemon.
  def docker_container_daemon
    log.debug 'Starting docker container as daemon'

    exit false unless configured? %w(docker_repo docker_image docker_tag)

    _create_container @hostname unless docker_container_check_existing @hostname
  end

  # Backend method for docker container login.
  def docker_container_login
    log.debug 'Logging in to docker container'

    exit false unless configured? %w(docker_repo docker_image docker_tag)

    docker_socket_start

    _create_container @hostname unless docker_container_check_existing @hostname
    _enter_container @hostname
  end

  # Backend method for docker container nuke.
  def docker_container_nuke
    log.debug 'Removing all docker containers'

    exit false unless configured? %w(docker_image)

    _get_containers.each do |container|
      _stop_container container
    end
  end

  # Backend method for docker container purge.
  def docker_container_purge
    log.debug 'Removing orphaned docker containers'

    exit false unless configured? %w(docker_image)

    _get_containers.each do |container|
      _stop_container container if docker_container_check_orphaned container
    end
  end

  # Create docker container.
  def _create_container(container)
    log.debug "Creating container \"#{container}\""

    if @docker_tag == 'latest'
      tag = docker_image_tag_latest_local
    else
      tag = @docker_tag
    end

    image = "#{@docker_repo}/#{@docker_image}:#{tag}"

    log.debug "Using docker image \"#{image}\""

    unless docker_image_tag_check_local tag
      log.error "Image \"#{image}\" does not exist"
      exit false
    end

    entrypoint = '/entrypoint.py '
    volume_dev = ''
    if options[:development]
      entrypoint = '/debug/entrypoint.py --debug '
      volume_dev = "--volume #{@workdir}/ansible/roles/geospin-ansible-devel/files:/debug "
    end

    cmd_docker_create = 'docker run ' +
        '--detach ' +
        "--env GEOSPIN_PROJECT_BASE_DIR=#{@workdir} " +
        '--env GOOGLE_APPLICATION_CREDENTIALS=/srv/google/default.json ' +
        "--env TZ=#{@timezone} " +
        "--hostname #{container} " +
        "--name #{container} " +
        '--privileged ' +
        '--rm ' +
        '--tty ' +
        "--volume #{@dockersock}:/var/run/docker.sock " +
        "--volume #{@homedir}/.config/gcloud:/srv/gcloud " +
        "--volume #{@homedir}/.google:/srv/google " +
        "--volume #{@homedir}:/homedir " +
        "--volume #{@workdir}:/project " +
        volume_dev +
        '--workdir /project ' +
        "#{image} " +
        entrypoint +
        "--gid #{@gid} " +
        "--hostsystem #{@hostsystem} " +
        "--uid #{@uid} " +
        "--username #{@username}"

    run cmd_docker_create
  end

  # Enter existing docker container.
  def _enter_container(container)
    log.debug "Entering container \"#{container}\""

    loginpoint = '/loginpoint.py '
    if options[:development]
      loginpoint = '/loginpoint.py --debug '
    end

    cmd_docker_enter = 'docker exec ' +
        '--interactive ' +
        '--tty ' +
        "#{container} " +
        loginpoint +
        "--username #{@username}"

    run_and_exit cmd_docker_enter
  end

  # Get all docker containers.
  # @return [Array] list of docker containers
  def _get_containers
    log.debug "Getting all #{@docker_image} containers"

    cmd_docker_get = 'docker ps ' +
        '--all ' +
        "--filter name=^#{@docker_image}_ " +
        '--quiet'

    stdout_str, stderr_str, status = run_and_check cmd_docker_get

    # convert stdout lines to array and return array
    stdout_str.split(/\n+/)
  end

  # Remove container.
  def _stop_container(container)
    log.debug "Stopping container \"#{container}\""

    cmd_docker_stop = 'docker stop ' +
        "#{container}"

    run cmd_docker_stop
  end

  # Enter existing docker container.
  def _run_command_in_container(container, command)
    log.debug "Running command \"#{command}\" in container \"#{container}\""

    cmd_docker_run_command = 'docker exec ' +
        "#{container} " +
        "su #{@username} " +
        "-c 'LANG=en_US.UTF-8 #{command}'"

    run_and_exit cmd_docker_run_command
  end
end
