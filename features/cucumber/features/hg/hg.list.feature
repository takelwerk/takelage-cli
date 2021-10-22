@hg
@hg.list

Feature: I can list hg repos

  Background:
    Given a directory named "my_git_origin"
    And I initialize a git workspace in "my_git_origin"
    And an empty file named "my_git_origin/my_file"
    And I commit everything in "my_git_origin" to git
    And a directory named "project"
    And I run `hg clone my_git_origin project/my_hg_clone`
    And an empty file named "project/Rakefile"
    And I cd to "project"

  Scenario: List hg repos
    When I successfully run `tau-cli hg list`
    Then the output should contain:
      """
      hg clone /tmp/cucumber/my_git_origin my_hg_clone
      """
