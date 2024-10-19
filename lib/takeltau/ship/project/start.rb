# frozen_string_literal: true

# tau ship project start
module ShipProjectStart
  # Start a takelship
  # rubocop:disable Metrics/MethodLength
  def ship_project_start(project)
    return false unless _ship_project_start_matrjoschka?

    takelship = _ship_info_lib_get_takelshipinfo
    project = _ship_info_lib_get_project project, takelship

    return false unless _ship_project_start_valid_project? takelship, project

    ports = _ship_ports_lib_get_ports(takelship, project)

    return false unless _ship_project_start_sailing? project, ports

    log.debug 'Writing port configuration to takelage.yml'
    _ship_ports_lib_write_ports(ports, project)

    log.debug "Starting takelship project \"#{project}\""
    _ship_container_lib_docker_privileged ports, project
    say "Started project \"#{project}\" on takelship \"#{_ship_container_lib_ship_hostname}\".\n\n"
    _ship_project_start_print_ports ports
  end
  # rubocop:enable Metrics/MethodLength

  private

  # check if we are inside a takelage container
  def _ship_project_start_matrjoschka?
    return true unless _docker_container_lib_check_matrjoschka

    say 'Cannot start a takelship from within a takelage container!'
    false
  end

  # check if the takelship is already existng
  def _ship_project_start_sailing?(project, ports)
    return true unless ship_container_check_existing

    say "The takelship \"#{_ship_container_lib_ship_hostname}\" is sailing with project \"#{project}\".\n\n"
    say _ship_project_start_print_ports ports
    false
  end

  # check if the project is a valid takelship project
  def _ship_project_start_valid_project?(takelship, project)
    return true if _ship_info_lib_valid_project? takelship, project

    say 'No valid project found!'
    say 'Hint: ship project list'
    false
  end

  # print ports after starting a takelship
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
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
    output.join("\n")
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  # get max length of left column
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
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
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
