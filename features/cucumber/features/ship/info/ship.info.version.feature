@ship
@ship.info
@ship.info.version

Feature: I can print the ship version

  Scenario: Print the version
    Given I read the takeltau version from the version file
    When I successfully run `ship-cli info version`
    Then the output should contain the takeltau version

  Scenario: Print the version
    Given I read the takeltau version from the version file
    When I successfully run `ship-cli version`
    Then the output should contain the takeltau version
