# frozen_string_literal: true

# tau ship container podman
module ShipContainerPodman
  # Run a podman command in a takelship
  def ship_container_podman(args)
    return false unless ship_container_check_existing

    _ship_container_lib_podman args.join(' ')
  end
end
