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
  cmd_stop_mock_container_cucumber =
    'tau-cli docker container check existing takelage-mock_cucumber_xinot-syzof && ' \
      'docker stop takelage-mock_cucumber_xinot-syzof; ' \
      'tau-cli docker container check network takelage-mock_cucumber_xinot-syzof && ' \
      'docker network rm takelage-mock_cucumber_xinot-syzof ' \
      '>/dev/null 2>&1'
  system cmd_stop_mock_container_cucumber
end

def _stop_mock_container_finite
  cmd_stop_mock_container_finite =
    'tau-cli docker container check existing takelage-mock_finite_xucih-zavis && ' \
      'docker stop takelage-mock_finite_xucih-zavis; ' \
      'tau-cli docker container check network takelage-mock_finite_xucih-zavis && ' \
      'docker network rm takelage-mock_finite_xucih-zavis ' \
      '>/dev/null 2>&1'
  system cmd_stop_mock_container_finite
end

def _stop_mock_container_infinite
  cmd_stop_mock_container_infinite =
    'tau-cli docker container check existing takelage-mock_infinite_xesoz-nivyr && ' \
      'docker stop takelage-mock_infinite_xesoz-nivyr; ' \
      'tau-cli docker container check network takelage-mock_infinite_xesoz-nivyr && ' \
      'docker network rm takelage-mock_infinite_xesoz-nivyr ' \
      '>/dev/null 2>&1'
  system cmd_stop_mock_container_infinite
end

def _stop_mock_container_takelship
  cmd_stop_mock_container_takelship =
    'ship-cli container check existing && ' \
      'docker stop takelship_xeciz-vigoc; ' \
      '>/dev/null 2>&1'
  system cmd_stop_mock_container_takelship
end
