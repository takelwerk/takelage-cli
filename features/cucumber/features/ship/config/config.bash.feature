@ship
@ship.config
@ship.config.bash

Feature: I can print the ship config

  Scenario: Print bash ship completion code
    When I successfully run `ship-cli config`
    Then the output should contain "ship_name: takelship"

  Scenario: Change a config key through an environment variable
    When I successfully run `env TAKELAGE_TAU_CONFIG_SHIP_NAME=pirateship ship-cli config`
    Then the output should contain "ship_name: pirateship"
