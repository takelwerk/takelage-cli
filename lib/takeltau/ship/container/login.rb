# frozen_string_literal: true

# tau ship container login
module ShipContainerLogin
  # Run a login command in a takelship
  def ship_container_login
    return false unless ship_container_check_existing

    _ship_container_lib_docker 'bash', tty='--tty'
  end
end
