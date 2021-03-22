# frozen_string_literal: true

# takelage mutagen socket create
module MutagenSocketCreate
  # Backend method for mutagen socket create.
  # rubocop:disable Metrics/MethodLength
  def mutagen_socket_create(name, containersock, hostsock)
    # See DockerContainerLib::_docker_container_lib_hostname
    socketname = "#{@hostname[-11..-1]}-#{name}"
    log.debug "Create the mutagen socket \"#{socketname}\" in the container " \
      "at \"#{containersock}\" pointing to the host at \"#{hostsock}\""

    return false unless mutagen_check_daemon

    return false if mutagen_socket_check socketname

    socket_created = _mutagen_socket_create_socket(socketname, containersock, hostsock)

    unless socket_created.include? 'Created session'
      log.debug "Unable to create mutagen socket \"#{socketname}\""
      return false
    end

    log.debug "Created the mutagen socket \"#{socketname}\""
    true
  end
  # rubocop:enable Metrics/MethodLength

  private

  # Get git branch.
  # rubocop:disable Metrics/MethodLength
  def _mutagen_socket_create_socket(socketname, containersock, hostsock)
    cmd_create_socket = format(
      config.active['cmd_mutagen_forward_socket_create'],
      socketname: socketname,
      containersock: containersock,
      hostsock: hostsock,
      username: @username,
      container: @hostname,
      hostlabel: @hostlabel,
      takellabel: @takellabel,
      takelsocklabel: @takelsocklabel

    )
    run cmd_create_socket
  end
  # rubocop:enable Metrics/MethodLength
end
