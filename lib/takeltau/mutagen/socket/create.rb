# frozen_string_literal: true

# tau mutagen socket create
module MutagenSocketCreate
  # Backend method for mutagen socket create.
  def mutagen_socket_create(name, containersock, hostsock)
    # See DockerContainerLib::_docker_container_lib_hostname
    socketname = "#{@hostname[-11..]}-#{name}"
    log.debug "Create the mutagen socket \"#{socketname}\" in the container " \
              "at \"#{containersock}\" pointing to the host at \"#{hostsock}\""

    return false if mutagen_socket_check socketname

    socket_created = _mutagen_socket_create_socket(socketname, containersock, hostsock)

    unless socket_created.include? 'Created session'
      log.debug "Unable to create mutagen socket \"#{socketname}\""
      return false
    end

    log.debug "Created the mutagen socket \"#{socketname}\""
    true
  end

  private

  # Get git branch.
  def _mutagen_socket_create_socket(socketname, containersock, hostsock)
    cmd_create_socket = format(
      config.active['cmd_mutagen_forward_socket_create'],
      socketname: socketname,
      containersock: containersock,
      hostsock: hostsock,
      username: @username,
      container: @hostname,
      hostlabel: @hostlabel,
      takellabel: @takellabel
    )
    run cmd_create_socket
  end
end
