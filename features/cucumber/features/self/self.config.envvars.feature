@self
@self.config
@self.config.envvars

Feature: I can print the envvars configuration

  Scenario: Print the home config
    Given an empty file "~/.takelage.yml"
    And an empty file "Rakefile"
    And an empty file "takelage.yml"
    When I successfully run `env TAKELAGE_TAU_CONFIG_GIT_HG_BRANCH=banana tau-cli self config envvars`
    Then the output should contain exactly:
      """
      ---
      git_hg_branch: banana
      """
