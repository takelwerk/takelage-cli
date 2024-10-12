# frozen_string_literal: true

# tau ship container check existing
module ShipContainerCheckExisting
  # Backend method for ship container check existing.
  # @return [Boolean] is container existing?
  def ship_container_check_existing
    ship_hostname = _ship_container_lib_ship_hostname
    log.debug "Checking if takelship \"#{ship_hostname}\" is existing"

    return false unless docker_check_daemon

    stdout_str = run _ship_container_cmd_check_existing ship_hostname

    if stdout_str.to_s.chomp.empty?
      log.debug "The takelship \"#{ship_hostname}\" is not existing"
      return false
    end

    log.debug "The takelship \"#{ship_hostname}\" is existing"
    true
  end

  private

  # Format command to check if ship container exists.
  def _ship_container_cmd_check_existing(ship_hostname)
    format(
      config.active['cmd_ship_container_check_existing_docker_ps'],
      docker: config.active['cmd_ship_docker'],
      ship_name: ship_hostname
    )
  end
end
