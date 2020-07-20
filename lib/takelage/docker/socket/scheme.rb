# frozen_string_literal: true

# takelage docker socket scheme
module DockerSocketScheme
  # Backend method for docker socket scheme.
  def docker_socket_scheme
    log.debug 'Getting docker socket scheme'

    socket_scheme = _socket_get_scheme _socket_get_config

    log.debug "Docker socket scheme is \n\"\"\"\n#{hash_to_yaml socket_scheme}\"\"\""

    socket_scheme
  end

  private

  # Get docker socket config.
  def _socket_get_config
    socket_config = []

    socket_config['docker_path'] = _socket_get_docker_daemon_path
    socket_config['docker_port'] = config.active['docker_socket_docker_daemon_port']
    socket_config['gpg_path'] = _socket_get_agent_socket_path
    socket_config['gpg_port'] = config.active['docker_socket_gpg_agent_port']
    socket_config['ssh_path'] = _socket_get_agent_ssh_socket_path
    socket_config['ssh_port'] = config.active['docker_socket_gpg_ssh_agent_port']

    socket_config
  end

  # Get docker socket path.
  def _socket_get_docker_daemon_path
    '/var/run/docker.sock'
  end

  # Get gpg agent socket path.
  def _socket_get_agent_socket_path
    cmd_agent_socket_path =
      config.active['cmd_docker_socket_config_agent_socket_path']
    (run cmd_agent_socket_path).chomp
  end

  # Get gpg ssh agent socket path.
  def _socket_get_agent_ssh_socket_path
    cmd_agent_ssh_socket_path =
      config.active['cmd_docker_socket_config_agent_ssh_socket_path']
    (run cmd_agent_ssh_socket_path).chomp
  end

  # Create socket scheme.
  def _socket_get_scheme(socket_config)
    { 'docker-daemon' => { 'path' => socket_config['docker_path'],
                           'host' => @socket_host,
                           'port' => socket_config['docker_port'] },
      'gpg-agent' => { 'path' => socket_config['gpg_path'],
                       'host' => @socket_host,
                       'port' => socket_config['gpg_port'] },
      'gpg-agent-ssh' => { 'path' => socket_config['ssh_path'],
                           'host' => @socket_host,
                           'port' => socket_config['ssh_port'] } }
  end
end
