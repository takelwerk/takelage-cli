# frozen_string_literal: true

# tau mutagen socket docker
module MutagenSocketDocker
  # Backend method for mutagen socket docker.
  # rubocop:disable Metrics/MethodLength
  def mutagen_socket_docker(hostsock)
    # See DockerContainerLib::_docker_container_lib_hostname
    socketname = "#{@hostname[-11..-1]}-docker"
    log.debug "Create the mutagen docker socket \"#{socketname}\" in the container " \
      "pointing to the host at \"#{hostsock}\""

    return false if mutagen_socket_check socketname

    socket_created = _mutagen_socket_docker_socket(socketname, hostsock)

    unless socket_created.include? 'Created session'
      log.debug "Unable to create mutagen docker socket \"#{socketname}\""
      return false
    end

    log.debug "Created the mutagen docker socket \"#{socketname}\""
    true
  end
  # rubocop:enable Metrics/MethodLength

  private

  # Get git branch.
  def _mutagen_socket_docker_socket(socketname, hostsock)
    cmd_create_socket = format(
      config.active['cmd_mutagen_forward_socket_docker'],
      socketname: socketname,
      hostsock: hostsock,
      container: @hostname,
      hostlabel: @hostlabel,
      takellabel: @takellabel
    )
    run cmd_create_socket
  end
end
