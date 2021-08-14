# frozen_string_literal: true

# takeltau mutagen socket terminate
module MutagenSocketTerminate
  # Backend method for mutagen socket terminate.
  def mutagen_socket_terminate(socket)
    log.debug "Terminate the mutagen socket \"#{socket}\""

    return false unless mutagen_check_daemon

    socket_terminated = _mutagen_socket_terminate_socket socket

    unless socket_terminated.exitstatus.zero?
      log.debug "Unable to terminated mutagen socket \"#{socket}\""
      return false
    end

    log.debug "Terminated the mutagen socket \"#{socket}\""
    true
  end

  private

  # Get git branch.
  def _mutagen_socket_terminate_socket(socketname)
    cmd_terminate_socket = format(
      config.active['cmd_mutagen_forward_socket_terminate'],
      socketname: socketname
    )
    try cmd_terminate_socket
  end
end
