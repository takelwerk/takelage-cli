@self
@self.list

Feature: I can print the list of commands

  Scenario: Print the list of commands
    When I successfully run `tau-cli self list`
    Then the output should contain:
      """
      tau list                                         # Alias for tau self list
      """
    And the output should contain:
      """
      tau self list                                    # List all commands
      """
    And the output should not contain "------"
    And the output should not contain "thor"
    And the output should not contain "takeltau:c_l_i:"
    And the output should not contain "COMMAND"

  Scenario: Print the list of commands
    When I successfully run `tau-cli list`
    Then the output should contain:
      """
      tau list                                         # Alias for tau self list
      """
    And the output should contain:
      """
      tau self list                                    # List all commands
      """
    And the output should not contain "------"
    And the output should not contain "thor"
    And the output should not contain "takeltau:c_l_i:"
    And the output should not contain "COMMAND"
