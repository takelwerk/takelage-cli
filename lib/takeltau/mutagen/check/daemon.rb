# frozen_string_literal: true

# tau info status mutagen
module MutagenCheckDaemon
  # Backend method for mutagen check daemon.
  # @return [Boolean] is mutagen available?
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def mutagen_check_daemon
    return true if @mutagen_daemon_available

    log.debug 'Check mutagen status'

    return false unless command_available_else_error? config.active['cmd_mutagen']

    # are we inside a takelage container?
    unless _docker_container_lib_check_matrjoschka
      unless _file_exists? config.active['mutagen_socket_path_mutagen_host']
        log.error 'The mutagen socket path on the host is not available'
        return false
      end

      log.debug 'The mutagen daemon is available'
      @mutagen_daemon_available = true
      return true
    end

    unless _file_exists? config.active['mutagen_socket_path_mutagen_container']
      log.error 'The mutagen socket path in the container is not available'
      return false
    end

    unless _mutagen_check_daemon_host_connection
      log.error 'A mutagen host connection is not available'
      return false
    end

    log.debug 'The mutagen daemon is available'
    @mutagen_daemon_available = true
    true
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  # Check mutagen host connection
  # rubocop:disable Metrics/MethodLength
  def _mutagen_check_daemon_host_connection
    check_host_connection = format(
      config.active['cmd_mutagen_check_daemon_host_connection'],
      hostlabel: @hostlabel
    )
    stdout, _, exitstatus = run_and_capture check_host_connection

    unless exitstatus.zero?
      log.debug 'There is no mutagen forward connection to the host'
      return false
    end

    unless stdout.include? 'Status: Forwarding'
      log.debug 'The mutagen forward connection to the host ' \
        'is not forwarding connections'
      return false
    end

    true
  end
  # rubocop:enable Metrics/MethodLength
end
