@self
@self.config
@self.config.project

Feature: I can print the project configuration

  Scenario: Print the project config
    Given a file named "takelage.yml" with:
      """
      ---
      bit_scope_list: tomato
      """
    And an empty file named "Rakefile"
    When I successfully run `tau-cli self config project`
    Then the output should contain exactly:
      """
      ---
      bit_scope_list: tomato
      """

  Scenario: Project configuration wins over home configuration
    Given a file named "~/takelage.yml" with:
      """
      ---
      bit_scope_list: banana
      """
    And a file named "takelage.yml" with:
      """
      ---
      bit_scope_list: tomato
      """
    And an empty file named "Rakefile"
    When I successfully run `tau-cli self config project`
    Then the output should contain exactly:
      """
      ---
      bit_scope_list: tomato
      """
