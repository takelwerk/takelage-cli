# frozen_string_literal: true

# tau ship container lib
module ShipContainerLib
  private

  # Run nonprivileged docker command
  def _ship_container_lib_docker_nonprivileged(command)
    return false unless docker_check_daemon 'cmd_ship_docker'

    cmd_docker_run_command = format(
      config.active['cmd_ship_project_start_docker_run_nonprivileged'],
      docker: config.active['cmd_ship_docker'],
      image: _ship_container_lib_image,
      command: command
    )
    run cmd_docker_run_command
  end

  # Run privileged docker command
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def _ship_container_lib_docker_privileged(ports, command)
    return false unless docker_check_daemon 'cmd_ship_docker'

    ship_data_dir = config.active['ship_data_dir']
    ship_env = config.active['ship_env']
    ports = _ship_container_lib_publish(ports)
    ports = config.active['ports'] unless config.active['ship_ports'].empty?
    cmd_docker_run_command = format(
      config.active['cmd_ship_project_start_docker_run_privileged'],
      docker: config.active['cmd_ship_docker'],
      ship_hostname: _ship_container_lib_ship_hostname,
      ship_env: ship_env,
      ports: ports,
      ship_data_dir: ship_data_dir,
      image: _ship_container_lib_image,
      command: command
    )
    run cmd_docker_run_command
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  # Run a docker command in a takelship container
  def _ship_container_lib_docker(command, tty = '--tty')
    return false unless docker_check_daemon 'cmd_ship_docker'

    cmd_docker_run_command = format(
      config.active['cmd_ship_container_docker'],
      docker: config.active['cmd_ship_docker'],
      ship_hostname: _ship_container_lib_ship_hostname,
      tty: tty,
      command: command
    )
    run_and_exit cmd_docker_run_command
  end

  # Run takelship docker stop command
  def _ship_container_lib_docker_stop
    return false unless docker_check_daemon 'cmd_ship_docker'

    return false unless ship_container_check_existing

    cmd_docker_stop_command = format(
      config.active['cmd_ship_project_start_docker_stop'],
      docker: config.active['cmd_ship_docker'],
      ship_hostname: _ship_container_lib_ship_hostname
    )
    run cmd_docker_stop_command
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
    workdir = Dir.getwd
    unique_name = "#{ship_name}_#{workdir}"
    digest = Digest::SHA256.bubblebabble unique_name
    unique = digest[0..10]
    format(
      config.active['ship_hostname'],
      ship_name: ship_name,
      unique: unique
    )
  end

  # Create publish ports string
  def _ship_container_lib_publish(ports)
    publish = []
    ports.each do |port|
      publish << "--publish \"127.0.0.1:#{port}:#{port}\""
    end
    publish.join(' ')
  end
end
