@self
@self.config
@self.config.home

Feature: I can print the home configuration

  Scenario: Print the home config
    Given a file named "~/.takelage.yml" with:
      """
      ---
      git_hg_branch: banana
      """
    And an empty file "Rakefile"
    And an empty file "takelage.yml"
    When I successfully run `tau-cli self config home`
    Then the output should contain exactly:
      """
      ---
      git_hg_branch: banana
      """
