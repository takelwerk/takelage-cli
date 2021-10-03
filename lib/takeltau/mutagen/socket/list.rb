# frozen_string_literal: true

# tau mutagen socket list
module MutagenSocketList
  # Backend method for mutagen socket list.
  # @return [String] List of takelage sockets
  def mutagen_socket_list
    log.debug 'List the mutagen takelage sockets'

    return false unless mutagen_check_daemon

    sockets = _mutagen_socket_list

    if sockets.to_s.empty?
      log.debug 'No mutagen takelage sockets found'
      return false
    end

    log.debug "Found mutagen takelage sockets: \n\"\"\"\n#{sockets}\"\"\""
    sockets.to_s
  end

  private

  # Get git branch.
  def _mutagen_socket_list
    cmd_list_socket = format(
      config.active['cmd_mutagen_forward_socket_list'],
      takellabel: @takellabel
    )
    run cmd_list_socket
  end
end
