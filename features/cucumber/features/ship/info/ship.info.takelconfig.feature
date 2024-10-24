@ship
@ship.info
@ship.info.takelconfig

@before_build_mock_images
@after_stop_mock_takelship_container

Feature: I can print the takelage config

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      ship_name: takelship-mock
      """
    And I get the active takeltau config

  Scenario: I can read the takelage config
    When I successfully run `unbuffer ship-cli info takelconfig`
    Then the output should contain "ship_name: takelship-mock"

  Scenario: I can overwrite a takelage config value with an environment variable
    When I successfully run `env TAKELAGE_TAU_CONFIG_SHIP_NAME=mockship unbuffer ship-cli info takelconfig`
    Then the output should contain "ship_name: mockship"
