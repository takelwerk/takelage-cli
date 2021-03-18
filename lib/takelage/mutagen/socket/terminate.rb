# frozen_string_literal: true

# takelage mutagen socket terminate
module MutagenSocketTerminate
  # Backend method for mutagen socket terminate.
  def mutagen_socket_terminate(socket)
    log.debug "Terminate the mutagen socket \"#{socket}\""

    socket_terminated = _mutagen_socket_terminate_socket socket

    cmd_remove = config.active['cmd_mutagen_forward_socket_remove']
    docker_container_command cmd_remove if cmd_remove && socket_terminated.exitstatus.zero?

    unless result.zero?
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
