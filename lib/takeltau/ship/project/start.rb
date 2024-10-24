# frozen_string_literal: true

# tau ship project start
module ShipProjectStart
  # Start a takelship
  def ship_project_start(project)
    return false unless _ship_project_start_matrjoschka?

    takelship = _ship_info_lib_get_takelshipinfo
    project = _ship_info_lib_get_project project, takelship
    return false unless _ship_project_start_valid_project? takelship, project

    ports = _ship_ports_lib_get_ports(takelship, project)
    return false if _ship_project_start_already_sailing? project, ports

    log.debug 'Writing port configuration to takelage.yml'
    _ship_ports_lib_write_ports(ports, project)

    log.debug "Starting takelship project \"#{project}\""
    ship_status = _ship_container_lib_docker_privileged ports, project
    return false unless _ship_container_lib_started? ship_status

    _ship_project_start_print_banner project
    _ship_project_start_print_ports ports
    true
  end

  private

  # check if we are inside a takelage container
  def _ship_project_start_matrjoschka?
    return true unless _docker_container_lib_check_matrjoschka

    say 'Cannot start a takelship from within a takelage container!'
    false
  end

  # check if the takelship is already existng
  def _ship_project_start_already_sailing?(project, ports)
    return false unless ship_container_check_existing

    _ship_project_start_print_banner project
    _ship_project_start_print_ports ports
    true
  end

  # check if the project is a valid takelship project
  def _ship_project_start_valid_project?(takelship, project)
    return true if _ship_info_lib_valid_project? takelship, project

    say 'No valid project found!'
    say 'Try: ship project list'
    false
  end

  # check if the ship started successfully
  def _ship_container_lib_started?(ship_status)
    return true if ship_status[2].zero?

    say 'Unable to start the takelship. The error message was:'
    say ship_status[1].to_s.strip.delete_prefix('"').delete_suffix('"')
    false
  end

  # print banner with status information
  def _ship_project_start_print_banner(project)
    ship_hostname = _ship_container_lib_ship_hostname
    ship_dir = _docker_container_lib_homify_dir config.active['project_root_dir']
    say "The takelship #{ship_hostname}"
    say "departed from #{ship_dir}"
    say "ships project #{project}"
    say
  end

  # print ports after starting a takelship
  def _ship_project_start_print_ports(ports)
    output = []
    max_length = _ship_project_start_get_maxlength ports
    ports.each_value do |port|
      next unless port['localhost'].to_i.between? 1, 65_535

      url = "localhost:#{port['localhost']}"
      service = "[#{port['service']} #{port['protocol']}]"
      description = port['description']
      description = " (#{description})" if port.key? 'description'
      output << "#{url.ljust(max_length['url'])} #{service.ljust(max_length['service'])}#{description}"
    end
    say output.join("\n")
  end

  # get max length of left column
  def _ship_project_start_get_maxlength(ports)
    max_length = {}
    max_length['url'] = 0
    max_length['service'] = 0
    ports.each_value do |port|
      localport = port['localhost']
      next unless localport.to_i.between? 1, 65_535

      url = "localhost:#{localport}"
      max_length['url'] = url.length if max_length['url'] < url.length

      service = "[#{port['service']} #{port['protocol']}]"
      max_length['service'] = service.length if max_length['service'] < service.length
    end
    max_length
  end
end
