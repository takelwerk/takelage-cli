# frozen_string_literal: true

# takelage info status mutagen
module MutagenCheckDaemon
  # Backend method for mutagen check daemon.
  # @return [Boolean] is mutagen available?
  # rubocop:disable Metrics/MethodLength
  def mutagen_check_daemon
    log.debug 'Check mutagen status'

    unless _file_exists? config.active['mutagen_socket_path']
      log.error 'mutagen socket is not available'
      return false
    end

    unless _mutagen_check_daemon_host_connection
      log.error 'mutagen host connection is not available'
      return false
    end

    log.debug 'mutagen is available'
    true
  end
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
end
