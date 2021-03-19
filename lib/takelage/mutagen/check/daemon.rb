# frozen_string_literal: true

# takelage info status mutagen
module MutagenCheckDaemon
  # Backend method for mutagen check daemon.
  # @return [Boolean] is mutagen available?
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def mutagen_check_daemon
    log.debug 'Check mutagen status'

    return false unless command_available? 'mutagen'

    # are we outside of a takelage container?
    unless _docker_container_lib_check_matrjoschka
      unless _mutagen_check_daemon_version
        log.error 'The mutagen daemin is not available'
        return false
      end

      log.debug 'The mutagen daemon is available'
      return true
    end

    unless _file_exists? config.active['mutagen_socket_path']
      log.error 'The mutagen socket is not available'
      return false
    end

    unless _mutagen_check_daemon_host_connection
      log.error 'A mutagen host connection is not available'
      return false
    end

    log.debug 'The mutagen daemon is available'
    true
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  # Check mutagen host connection
  def _mutagen_check_daemon_host_connection
    check_host_connection = format(
      config.active['cmd_mutagen_check_daemon_host_connection'],
      hostlabel: @hostlabel
    )
    host_connection = try check_host_connection
    host_connection.exitstatus.zero?
  end

  # Check mutagen version
  def _mutagen_check_daemon_version
    version = try config.active['cmd_mutagen_check_daemon_version']
    version.exitstatus.zero?
  end
end
