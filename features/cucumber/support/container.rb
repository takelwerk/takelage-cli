# frozen_string_literal: true

def takelage_container_after_all
  stop_mock_container
end

def stop_mock_container
  _stop_mock_container_cucumber
  _stop_mock_container_finite
  _stop_mock_container_infinite
  _stop_mock_container_takelship
end

private

def _stop_mock_container_cucumber
  _stop_container 'takelage-mock_cucumber_xinot-syzof'
  _stop_network 'takelage-mock_cucumber_xinot-syzof'
end

def _stop_mock_container_finite
  _stop_container 'takelage-mock_finite_xucih-zavis'
  _stop_network 'takelage-mock_finite_xucih-zavis'
end

def _stop_mock_container_infinite
  _stop_container 'takelage-mock_infinite_xesoz-nivyr'
  _stop_network 'takelage-mock_infinite_xesoz-nivyr'
end

def _stop_mock_container_takelship
  _stop_container 'takelship_xeciz-vigoc'
  _stop_container 'takelship_xepeb-niruc'
end

def _stop_container(container)
  cmd_stop_container = \
    "docker ps --filter name=^#{container}$ " \
      '--quiet >/dev/null 2>&1 && ' \
      "docker stop #{container} >/dev/null 2>&1"
  system cmd_stop_container
end

def _stop_network(network)
  cmd_stop_network = \
    "docker network ls --filter name=^#{network}$ " \
      '--quiet >/dev/null 2>&1 && ' \
      "docker network rm #{network} >/dev/null 2>&1"
  system cmd_stop_network
end
