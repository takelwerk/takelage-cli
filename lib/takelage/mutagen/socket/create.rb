# frozen_string_literal: true

# takelage mutagen socket create
module MutagenSocketCreate
  # Backend method for mutagen socket create.
  def mutagen_socket_create(containersock, hostsock)
    log.debug "Create the mutagen socket \"#{@socketname}\" in the container" \
      "at \"#{containersock}\" pointing to the host at \"#{hostsock}\""

    socket_created = _mutagen_socket_create_socket(containersock, hostsock)

    unless socket_created.include? 'Created session'
      log.debug "Unable to create mutagen socket \"#{@socketname}\""
      return false
    end

    log.debug "Created the mutagen socket \"#{@socketname}\""
    true
  end

  private

  # Get git branch.
  # rubocop:disable Metrics/MethodLength
  def _mutagen_socket_create_socket(containersock, hostsock)
    cmd_create_socket = format(
      config.active['cmd_mutagen_forward_socket_create'],
      socketname: @socketname,
      containersock: containersock,
      hostsock: hostsock,
      username: @username,
      container: @hostname,
      hostlabel: @hostlabel,
      takellabel: @takellabel
    )
    run cmd_create_socket
  end
  # rubocop:enable Metrics/MethodLength
end
