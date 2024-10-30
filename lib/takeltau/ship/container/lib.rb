# frozen_string_literal: true

# tau ship container lib
module ShipContainerLib
  private

  # Run nonprivileged docker command
  def _ship_container_lib_docker_nonprivileged(command, args = '')
    args = _ship_container_lib_ship_args args, config.active['ship_run_args_nonprivileged']
    cmd_docker_run_command = format(
      config.active['cmd_ship_project_start_docker_run_nonprivileged'],
      ship_docker: config.active['cmd_ship_docker'],
      ship_run_args_nonprivileged: args,
      image: _ship_container_lib_image,
      command: command
    )
    run cmd_docker_run_command
  end

  # Run privileged docker command
  # rubocop:disable Metrics/AbcSize
  def _ship_container_lib_docker_privileged(ports, command, args: '', ship_hostname_suffix: nil, publish_ports: true)
    suffix = "_#{ship_hostname_suffix}" unless ship_hostname_suffix.nil?
    ship_hostname = "#{_ship_container_lib_ship_hostname}#{suffix}"
    args = _ship_container_lib_ship_args args, config.active['ship_run_args_privileged']
    ship_env = _ship_container_lib_ship_env ports
    ports = _ship_container_lib_publish(ports, publish_ports)
    ship_data_dir = config.active['ship_data_dir']
    cmd_docker_run_command = format(
      config.active['cmd_ship_project_start_docker_run_privileged'],
      ship_docker: config.active['cmd_ship_docker'],
      ship_hostname: ship_hostname,
      ship_env: ship_env,
      ports: ports,
      project_root_dir: config.active['project_root_dir'],
      ship_data_dir: ship_data_dir,
      ship_run_args_privileged: args,
      image: _ship_container_lib_image,
      command: command
    )
    run_and_capture cmd_docker_run_command
  end

  # rubocop:enable Metrics/AbcSize

  # Run a docker command in a takelship container
  def _ship_container_lib_docker_exec(command, tty = '--tty')
    cmd_docker_run_command = format(
      config.active['cmd_ship_container_docker'],
      ship_docker: config.active['cmd_ship_docker'],
      ship_hostname: _ship_container_lib_ship_hostname,
      tty: tty,
      command: command
    )
    run_and_exit cmd_docker_run_command
  end

  # Return privileged args
  def _ship_container_lib_ship_args(args, config_args)
    args = "#{args} #{config_args}" if config_args
    args_debug = '--env TAKELSHIP_DEBUG=true'
    args = "#{args} #{args_debug}" if log.level == Logger::DEBUG
    args
  end

  # Return takelship image
  def _ship_container_lib_image
    ship_user = config.active['ship_user']
    ship_repo = config.active['ship_repo']
    ship_tag = config.active['ship_tag']
    "#{ship_user}/#{ship_repo}:#{ship_tag}"
  end

  # Create unique docker hostname
  def _ship_container_lib_ship_hostname
    ship_name = config.active['ship_name']
    workdir = config.active['project_root_dir']
    unique_name = "#{ship_name}_#{workdir}"
    digest = Digest::SHA256.bubblebabble unique_name
    unique = digest[0..10]
    format(
      config.active['ship_hostname'],
      ship_name: ship_name,
      unique: unique
    )
  end

  # Create ship environment string
  def _ship_container_lib_ship_env(ports)
    ship_env = [config.active['ship_env']]
    ports.each do |key, port|
      envvar = "TAKELSHIP_#{key}".upcase
      envstr = "--env #{envvar}=#{port['localhost']}"
      ship_env << envstr
    end
    ship_env << _ship_container_lib_takelship_update
    ship_env.join(' ')
  end

  # add env parameter with update configuration
  def _ship_container_lib_takelship_update
    update_true = '--env TAKELSHIP_UPDATE=true'
    update_false = '--env TAKELSHIP_UPDATE=false'
    log.debug 'Will update by default'
    update = update_true
    unless config.active['ship_update']
      log.debug "Won't update as config key 'ship_update' is 'false'"
      update = update_false
    end
    if ENV.key?('TAKELSHIP_UPDATE')
      if ENV['TAKELSHIP_UPDATE']
        log.debug "Will update as env var 'TAKELSHIP_UPDATE' is 'true'"
        update = update_true
      else
        log.debug "Won't update as env var 'TAKELSHIP_UPDATE' is 'false'"
        update = update_false
      end
    end
    update
  end

  # Create publish ports string
  def _ship_container_lib_publish(ports, publish_ports)
    return '' unless publish_ports

    publish = []
    ports.each do |port|
      shipport = port[1]['takelship'].to_s
      localport = port[1]['localhost'].to_s
      next unless localport.to_i.between? 1, 65_535

      publish << "--publish \"127.0.0.1:#{localport}:#{shipport}\""
    end
    publish.join(' ')
  end

  # Get all takelship containers.
  # @return [Array] list of takelship containers
  def _ship_container_lib_get_containers
    ship_name = config.active['ship_name']
    log.debug "Getting all #{ship_name} containers"

    cmd_docker_get = format(
      config.active['cmd_docker_container_get_containers'],
      docker: config.active['cmd_docker'],
      docker_repo: ship_name
    )

    # convert stdout lines to array and return array
    (run cmd_docker_get).split(/\n+/)
  end

  # Get the mounted takelship directory
  def _ship_container_lib_get_mounted_dir
    ship_hostname = _ship_container_lib_ship_hostname
    log.debug 'Getting mounted directory from ' \
                "takelship container \"#{ship_hostname}\""

    cmd_get_mounted_dir = format(
      config.active['cmd_docker_container_get_mounted_dir'],
      ship_docker: config.active['cmd_ship_docker'],
      docker: config.active['cmd_ship_docker'],
      ship_hostname: ship_hostname
    )

    run cmd_get_mounted_dir
  end

  # Remove takelship container
  def _ship_container_lib_remove_container(container)
    cmd_docker_remove_container = format(
      config.active['cmd_docker_container_stop_container'],
      docker: config.active['cmd_docker'],
      container: container
    )

    run cmd_docker_remove_container
  end
end
