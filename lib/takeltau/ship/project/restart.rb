# frozen_string_literal: true

# tau ship project restart
module ShipProjectRestart
  # Restart a takelship
  def ship_project_restart(project)
    say ship_container_stop
    sleep 1 until ship_project_start project, mute: true
    true
  end
end
