# frozen_string_literal: true

# takelage docker container module
module DockerContainerModule
  # Backend method for docker container run.
  def docker_container_command(command)
    log.debug 'Running command in container'

    return false unless docker_check_running

    docker_socket_start

    _docker_container_create_network @hostname unless _check_network @hostname

    unless docker_container_check_existing @hostname
      return false unless _docker_container_create_container @hostname
    end

    _run_command_in_container @hostname, command
  end

  # Backend method for docker container daemon.
  def docker_container_daemon
    log.debug 'Starting docker container as daemon'

    return false unless docker_check_running

    _docker_container_create_network @hostname unless _check_network @hostname

    unless docker_container_check_existing @hostname
      return false unless _docker_container_create_container @hostname
    end

    true
  end

  # Backend method for docker container login.
  def docker_container_login
    log.debug 'Logging in to docker container'

    return false unless docker_check_running

    _docker_container_login_check_outdated
    docker_socket_start
    _docker_container_create_network @hostname unless _check_network @hostname

    unless docker_container_check_existing @hostname
      return false unless _docker_container_create_container @hostname
    end

    cmd_enter_container = _docker_container_enter_container @hostname

    run_and_exit cmd_enter_container
  end

  # Backend method for docker container nuke.
  def docker_container_nuke
    log.debug 'Removing all docker containers'

    return false unless docker_check_running

    return false if _docker_container_harakiri?

    networks = _docker_container_kill_existing_containers

    networks.each do |network|
      _docker_container_remove_network network if _check_network network
    end
  end

  # Backend method for docker container purge.
  def docker_container_purge
    log.debug 'Removing orphaned docker containers'

    return false unless docker_check_running

    networks = _docker_container_kill_orphaned_containers

    networks.each do |network|
      _docker_container_remove_network network if _check_network network
    end
  end

  private

  # Check if newer docker container is available.
  def _docker_container_login_check_outdated
    return if @docker_tag == 'latest'

    outdated = docker_image_check_outdated @docker_tag
    return unless outdated

    tag_latest = docker_image_tag_latest_remote
    log.warn "#{@docker_user}/#{@docker_repo}:#{@docker_tag} is outdated"
    log.warn "#{@docker_user}/#{@docker_repo}:#{tag_latest} is available"
  end

  # Create docker container.
  # rubocop:disable Metrics/MethodLength
  def _docker_container_create_container(container)
    log.debug "Creating container \"#{container}\""

    image = "#{@docker_user}/#{@docker_repo}:#{@docker_tag}"

    return false unless _docker_container_image_available? image

    log.debug "Using docker image \"#{image}\""

    unless @socket_host == '127.0.0.1'
      addhost = "--add-host host.docker.internal:#{@socket_host}"
    end

    entrypoint = '/entrypoint.py '
    volume_dev = ''
    if options[:development]
      entrypoint += ' --debug '
      volume_dev = "--volume #{@workdir}/#{@docker_debug}:/debug "
    end

    cmd_docker_create =
      format(
        config.active['cmd_docker_container_create'],
        workdir: @workdir,
        timezone: @timezone,
        container: container,
        dockersock: @dockersock,
        homedir: @homedir,
        volume_dev: volume_dev,
        image: image,
        addhost: addhost,
        dockerrun_options: @dockerrun_options,
        entrypoint: entrypoint,
        gid: @gid,
        uid: @uid,
        username: @username,
        gpg_agent_port: @gpg_agent_port,
        gpg_ssh_agent_port: @gpg_ssh_agent_port,
        extra: @entrypoint_extra,
        entrypoint_options: @entrypoint_options
      )

    run cmd_docker_create
    true
  end
  # rubocop:enable Metrics/MethodLength

  # Check if docker image is available
  def _docker_container_image_available?(image)
    return true if docker_image_tag_list_local.include? @docker_tag

    log.error "No local image \"#{image}\" available"
    log.info "Try: docker pull #{image}"
    false
  end

  # Create docker network.
  def _docker_container_create_network(network)
    log.debug "Create network \"#{network}\""

    cmd_create_network =
      format(
        config.active['cmd_docker_container_create_network'],
        network: network
      )

    run cmd_create_network
  end

  # Enter existing docker container.
  def _docker_container_enter_container(container)
    log.debug "Entering container \"#{container}\""

    loginpoint = '/loginpoint.py'
    loginpoint += ' --debug ' if options[:development]

    format(
      config.active['cmd_docker_container_enter_container'],
      container: container,
      loginpoint: loginpoint,
      username: @username
    )
  end

  # Check if we are running tau nuke inside a takelage container
  def _docker_container_harakiri?
    hostname = ENV['HOSTNAME'] || ''
    return false unless hostname.start_with? "#{@docker_repo}_"

    log.error "Please run \"tau nuke\" outside of #{@docker_repo} containers"
    log.info "Run \"tau purge\" to remove orphaned #{@docker_repo} containers"
    true
  end

  # Get container name by id.
  def _docker_container_get_container_name_by_id(container)
    log.debug "Getting name of container \"#{container}\""

    cmd_get_container_name_by_id =
      format(
        config.active['cmd_docker_container_get_container_name'],
        container: container
      )

    stdout_str = run cmd_get_container_name_by_id

    name = stdout_str.chomp

    log.debug "Container #{container} has name \"#{name}\""

    name
  end

  # Get all docker containers.
  # @return [Array] list of docker containers
  def _docker_container_get_containers
    log.debug "Getting all containers of image \"#{@docker_repo}\""

    cmd_docker_get =
      format(
        config.active['cmd_docker_container_get_containers'],
        docker_repo: @docker_repo
      )

    stdout_str = run cmd_docker_get

    # convert stdout lines to array and return array
    stdout_str.split(/\n+/)
  end

  # Kill all docker containers and return list of networks
  def _docker_container_kill_existing_containers
    networks = []
    _docker_container_get_containers.each do |container|
      name = _docker_container_get_container_name_by_id container
      _docker_container_stop_container container
      networks << name unless networks.include? name
    end
    networks
  end

  # Kill orphaned docker containers and return list of networks
  def _docker_container_kill_orphaned_containers
    networks = []

    _docker_container_get_containers.each do |container|
      next unless docker_container_check_orphaned container

      name = _docker_container_get_container_name_by_id container
      _docker_container_stop_container container
      networks << name unless networks.include? name
    end
    networks
  end

  # Remove docker network.
  def _docker_container_remove_network(network)
    log.debug "Remove network \"#{network}\""

    cmd_remove_network =
      format(
        config.active['cmd_docker_container_remove_network'],
        network: network
      )

    run cmd_remove_network
  end

  # Enter existing docker container.
  def _run_command_in_container(container, command)
    log.debug "Running command \"#{command}\" in container \"#{container}\""

    cmd_docker_run_command =
      format(
        config.active['cmd_docker_container_docker_exec'],
        container: container,
        username: @username,
        command: command
      )

    run_and_exit cmd_docker_run_command
  end

  # Stop container.
  def _docker_container_stop_container(container)
    log.debug "Stopping container \"#{container}\""

    cmd_docker_stop =
      format(
        config.active['cmd_docker_container_stop_container'],
        container: container
      )

    run cmd_docker_stop
  end
end
