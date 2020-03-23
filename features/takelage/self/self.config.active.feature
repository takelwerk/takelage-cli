@self
@self.config
@self.config.active

Feature: I can print the active configuration

  Scenario: Print the active config
    Given a file named "~/.takelage.yml" with:
      """
      ---
      food: tomato
      element: fire
      """
    And a file named "takelage.yml" with:
      """
      ---
      food: banana
      """
    And an empty file named "Rakefile"
    When I successfully run `tau-cli self config active`
    Then the output should contain:
      """
      element: fire
      """
    And the output should contain:
      """
      food: banana
      """

  Scenario: Print the active config
    Given a file named "~/.takelage.yml" with:
      """
      ---
      food: tomato
      element: fire
      """
    And a file named "takelage.yml" with:
      """
      ---
      food: banana
      """
    And an empty file named "Rakefile"
    When I successfully run `tau-cli config`
    Then the output should contain:
      """
      element: fire
      """
    And the output should contain:
      """
      food: banana
      """
