@self
@self.config
@self.config.default

Feature: I can print the default configuration

  Scenario: Print the default config
    Given the takeltau default configuration
    When I successfully run `tau-cli self config default`
    And the output should contain exactly the default config
