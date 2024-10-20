# frozen_string_literal: true

# tau ship container logs
module ShipContainerLogs
  # Start a takelship
  def ship_container_logs(args)
    ship_hostname = _ship_container_lib_ship_hostname

    unless ship_container_check_existing
      say "The takelship #{ship_hostname} is not sailing."
      return false
    end

    log.debug 'Printing docker logs'
    _ship_container_logs_print(ship_hostname, args.join(' '))
  end

  private

  def _ship_container_logs_print(ship_hostname, args)
    cmd_follow_logs = format(
      config.active['cmd_ship_container_logs'],
      ship_docker: config.active['cmd_ship_docker'],
      ship_hostname: ship_hostname,
      args: args
    )
    run_and_exit cmd_follow_logs
  end
end
