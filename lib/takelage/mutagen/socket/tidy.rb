# frozen_string_literal: true

# takelage mutagen socket tidy
module MutagenSocketTidy
  # Backend method for mutagen socket tidy.
  def mutagen_socket_tidy
    log.debug "Remove the mutagen daemon files in container \"#{@hostname}\""

    container_existing = docker_container_check_existing @hostname
    cmd_remove = config.active['cmd_mutagen_forward_socket_remove']
    return false unless container_existing && cmd_remove.empty?

    result = docker_container_command(cmd_remove)
    log.debug result
    unless result
      log.error "Unable to remove the mutagen daemon files in container \"#{@hostname}\""
      return false
    end

    log.debug "Removed the mutagen daemon files in container \"#{@hostname}\""
    true
  end
end
