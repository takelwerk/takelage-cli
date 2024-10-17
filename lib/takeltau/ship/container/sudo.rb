# frozen_string_literal: true

# tau ship container sudo
module ShipContainerSudo
  # Run a sudo command in a takelship
  def ship_container_sudo(args)
    return false unless ship_container_check_existing

    _ship_container_lib_docker_exec args.join(' ')
  end
end
