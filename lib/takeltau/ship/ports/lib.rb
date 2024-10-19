# frozen_string_literal: true

# tau ship ports lib
module ShipPortsLib
  private

  # get the ports of a takelship
  # rubocop:disable Metrics/MethodLength
  def _ship_ports_lib_get_ports(takelship, takelproject)
    ports = _ship_ports_lib_get_ports_docker(takelship)
    takelship['projects'].each do |project|
      next unless project['name'] == takelproject

      project['services'].each do |service|
        next unless service.key? 'ports'

        service['ports'].each do |port|
          key = _ship_ports_lib_generate_key port, service
          ports[key] = _ship_ports_lib_get_port key, port, service
        end
      end
    end
    ports
  end
  # rubocop:enable Metrics/MethodLength

  # write ports to project takelage.yml
  def _ship_ports_lib_write_ports(ports, project)
    config_project = _ship_ports_lib_get_project_config ports, project
    project_dir = config.active['project_root_dir']
    config_file = "#{project_dir}/takelage.yml"
    write_file config_file, config_project.to_yaml
  end

  # get current project config
  # the values are added/updated unconditionally
  # the merge with the existing values has been done here:
  # ConfigModule::TakeltauConfig::_config_merge_active
  # and here: _ship_ports_lib_get_localhost_port
  def _ship_ports_lib_get_project_config(ports, project)
    config_project = config.project
    ports.each do |key, port|
      config_project[key] = port['localhost']
    end
    config_project['ship_default_project'] = project
    config_project.sort.to_h
  end

  # map the podman socket port (aka "DOCKER_HOST")
  # returns a hash unlike the get_port method
  # rubocop:disable Metrics/MethodLength
  def _ship_ports_lib_get_ports_docker(takelship)
    takel_docker = takelship['docker_host']
    docker_key = "ship_ports_dind_docker_#{takel_docker}"
    local_docker = _ship_ports_lib_get_localhost_port docker_key, takel_docker
    {
      docker_key => {
        'service' => 'dind',
        'protocol' => 'docker',
        'takelship' => takel_docker.to_i,
        'localhost' => local_docker
      }
    }
  end
  # rubocop:enable Metrics/MethodLength

  # map a takelship port
  def _ship_ports_lib_get_port(key, port, service)
    localhost = _ship_ports_lib_get_localhost_port key, port['port']
    {
      'service' => service['name'],
      'protocol' => port['protocol'],
      'takelship' => port['port'],
      'localhost' => localhost
    }
  end

  # get new port on localhost for takelport
  def _ship_ports_lib_get_localhost_port(key, port)
    env_var = "TAKELAGE_TAU_CONFIG_#{key}".upcase
    return ENV[env_var].to_i if ENV.key? env_var

    return config.active[key] if config.active.key? key

    _ship_ports_lib_get_free_port port
  end

  # derive a random free port from a port
  def _ship_ports_lib_get_free_port(port)
    localport = 0
    loop do
      offset = _ship_ports_lib_get_offset
      localport = port.to_i + offset
      break unless _ship_ports_lib_port_open? localport
    end
    localport
  end

  # generate dynamic takelconfig key
  def _ship_ports_lib_generate_key(port, service)
    key = "ship_ports_#{service['name']}_#{port['protocol']}_#{port['port']}"
    key.gsub('-', '_')
  end

  # generate random offset
  def _ship_ports_lib_get_offset
    # this results in ports
    # from 30000 + 15000 = 45000
    # to 40000 + 25000 = 65000
    # max port number: 65535
    rand(15_000..25_000)
  end

  # check if a port on the host is open
  def _ship_ports_lib_port_open?(port)
    log.debug "Checking if port #{port} is open"
    begin
      Socket.tcp('127.0.0.1', port, connect_timeout: 5)
      true
    rescue Errno::ECONNREFUSED
      false
    end
  end
end
