# frozen_string_literal: true

# takeltau mutagen socket check
module MutagenSocketCheck
  # Backend method for mutagen socket check.
  # @return [Boolean] Does a mutagen socket exist?
  def mutagen_socket_check(socket)
    log.debug "Check if the mutagen socket \"#{socket}\" exists"

    return false unless mutagen_check_daemon

    socket_exists = _mutagen_socket_check_socket(socket)

    unless socket_exists.exitstatus.zero?
      log.debug "A mutagen socket \"#{socket}\" does not exist"
      return false
    end

    log.debug "The mutagen socket \"#{socket}\" does exist"
    true
  end

  private

  # Get git branch.
  def _mutagen_socket_check_socket(socketname)
    cmd_check_socket = format(
      config.active['cmd_mutagen_forward_socket_check'],
      socketname: socketname
    )
    try cmd_check_socket
  end
end
