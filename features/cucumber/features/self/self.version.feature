@self
@self.version

Feature: I can print the version

  Scenario: Print the version
    Given I read the takeltau version from the version file
    When I successfully run `tau-cli self version`
    Then the output should contain the takeltau version

  Scenario: Print the version
    Given I read the takeltau version from the version file
    When I successfully run `tau-cli version`
    Then the output should contain the takeltau version
