@logging

Feature: I can log debug messages

  Scenario: Loglevel DEBUG prints debug log messages
    When I successfully run `tau-cli --loglevel debug`
    Then the output should contain "[DEBUG]"

  Scenario: Option --debug prints debug log messages
    When I successfully run `tau-cli --debug`
    Then the output should contain "[DEBUG]"

  Scenario: Loglevel INFO does not print debug log messages
    When I successfully run `tau-cli --loglevel info`
    Then the output should not contain "[DEBUG]"

  Scenario: No explicit loglevel not print debug log messages
    When I successfully run `tau-cli`
    Then the output should not contain "[DEBUG]"
