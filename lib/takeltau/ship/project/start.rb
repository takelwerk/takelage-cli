# frozen_string_literal: true

# tau ship project start
module ShipProjectStart
  # Start a takelship
  def ship_project_start(project)
    return false unless _ship_project_start_prerequisites_fulfilled?

    takelship = _ship_info_lib_get_takelshipinfo
    project = _ship_info_lib_get_project project, takelship

    return false unless _ship_project_start_valid_project? takelship, project

    ports = _ship_ports_lib_get_ports(takelship, project)

    log.debug 'Writing port configuration to takelage.yml'
    _ship_ports_lib_write_ports(ports, project)

    log.debug "Starting takelship project \"#{project}\""
    _ship_container_lib_docker_privileged ports, project

    _ship_project_start_print_ports project, ports
  end

  private

  # check prerequisistes
  def _ship_project_start_prerequisites_fulfilled?
    if _docker_container_lib_check_matrjoschka
      say 'Cannot start a takelship from within a takelage container!'
      return false
    end

    if ship_container_check_existing
      say "Container \"#{_ship_container_lib_ship_hostname}\" is already started!"
      return false
    end

    true
  end

  # check if the project is a valid takelship project
  def _ship_project_start_valid_project?(takelship, project)
    return true if _ship_info_lib_valid_project? takelship, project

    say 'No valid project found!'
    false
  end

  # print ports after starting a takelship
  def _ship_project_start_print_ports(project, ports)
    output = []
    output << "Started takelship project \"#{project}\" with these services:\n"
    max_length = _ship_project_start_get_maxlength ports

    ports.each_value do |port|
      next unless port['localhost'].to_i.between? 1, 65_535

      left = "localhost:#{port['localhost']}"
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
      next unless localport.to_i.between? 1, 65_535

      left_string = "localhost:#{localport}"
      max_length = left_string.length if max_length < left_string.length
    end
    max_length
  end
end
