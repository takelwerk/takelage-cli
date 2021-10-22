@self
@self.commands

Feature: I can print the commands of commands

  Scenario: Print the commands of commands
    When I successfully run `tau-cli self commands`
    Then the output should contain:
      """
      tau commands                                     # Alias for tau self commands
      """
    And the output should contain:
      """
      tau self commands                                # List all commands
      """
    And the output should not contain "------"
    And the output should not contain "thor"
    And the output should not contain "takeltau:c_l_i:"
    And the output should not contain "COMMAND"

  Scenario: Print the list of commands
    When I successfully run `tau-cli commands`
    Then the output should contain:
      """
      tau commands                                     # Alias for tau self commands
      """
    And the output should contain:
      """
      tau self commands                                # List all commands
      """
    And the output should not contain "------"
    And the output should not contain "thor"
    And the output should not contain "takeltau:c_l_i:"
    And the output should not contain "COMMAND"
