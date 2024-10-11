# frozen_string_literal: true

def takelship_container_after_all
  stop_mock_takelship_container
end

def stop_mock_takelship_container
  _stop_mock_container_cucumber
  _stop_mock_takelship_container
end

private

def _stop_mock_takelship_container
  cmd_stop_mock_takelship_container_infinite =
    'ship-cli container check existing && ' \
      'docker stop takelship_xeciz-vigoc; ' # \
      # '>/dev/null 2>&1'
  system cmd_stop_mock_takelship_container_infinite
end
