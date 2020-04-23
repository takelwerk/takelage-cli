# frozen_string_literal: true

def container_after_all
  stop_mock_container
end

def stop_mock_container
  _stop_mock_container_cucumber
  _stop_mock_container_finite
  _stop_mock_container_infinite
end

private

def _stop_mock_container_cucumber
  cmd_stop_mock_container_cucumber =
    'tau-cli docker container check existing takelage-mock_cucumber && ' \
      'docker stop takelage-mock_cucumber; ' \
      'tau-cli docker container check network takelage-mock_cucumber && ' \
      'docker network rm takelage-mock_cucumber ' \
      '>/dev/null 2>&1'
  system cmd_stop_mock_container_cucumber
end

def _stop_mock_container_finite
  cmd_stop_mock_container_finite =
    'tau-cli docker container check existing takelage-mock_finite && ' \
      'docker stop takelage-mock_finite; ' \
      'tau-cli docker container check network takelage-mock_finite && ' \
      'docker network rm takelage-mock_finite ' \
      '>/dev/null 2>&1'
  system cmd_stop_mock_container_finite
end

def _stop_mock_container_infinite
  cmd_stop_mock_container_infinite =
    'tau-cli docker container check existing takelage-mock_infinite && ' \
      'docker stop takelage-mock_infinite; ' \
      'tau-cli docker container check network takelage-mock_infinite && ' \
      'docker network rm takelage-mock_infinite ' \
      '>/dev/null 2>&1'
  system cmd_stop_mock_container_infinite
end
