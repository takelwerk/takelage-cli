# frozen_string_literal: true

# tau ship project start
module ShipProjectStart
  # Start a takelship
  def ship_project_start(project)
    return false if _docker_container_lib_check_matrjoschka

    return false if ship_container_check_existing

    takelship = _ship_info_lib_get_takelshipinfo
    project = _ship_info_lib_get_project(project, takelship)

    return false unless _ship_info_lib_valid_project? takelship, project

    ports = _ship_ports_lib_get_ports(takelship, project)

    log.debug 'Writing port configuration to takelage.yml'
    _ship_ports_lib_write_ports(ports, project)

    log.debug "Starting takelship project \"#{project}\""
    _ship_container_lib_docker_privileged ports, project

    _ship_project_start_print_ports project, ports
  end

  private

  # print ports after starting a takelship
  def _ship_project_start_print_ports(project, ports)
    output = []
    output << "Started takelship project \"#{project}\" with these services:\n"
    max_length = _ship_project_start_get_maxlength ports

    ports.each_value do |port|
      localport = port['localhost']

      next unless localport.to_i.between? 1, 65535

      left = "localhost:#{localport}"
      right = "(#{port['service']} #{port['protocol']})"
      output << "#{left.ljust(max_length)} #{right}"
    end
    output.join("\n")
  end

  # get max length of left column
  def _ship_project_start_get_maxlength(ports)
    max_length = 0
    ports.each_value do |port|
      localport = port['localhost']
      next unless localport.to_i.between? 1, 65535

      left_string = "localhost:#{localport}"
      max_length = left_string.length if max_length < left_string.length
    end
    max_length
  end
end
