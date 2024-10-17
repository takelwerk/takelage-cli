# frozen_string_literal: true

# tau ship container command
module ShipContainerCommand
  # Run a command in a takelship
  def ship_container_command(args)
    return false unless ship_container_check_existing

    _ship_container_lib_docker_exec "pod #{args.join(' ')}"
  end
end
