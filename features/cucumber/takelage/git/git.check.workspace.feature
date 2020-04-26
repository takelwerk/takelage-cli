@git
@git.check
@git.check.workspace

Feature: I can check if a git workspace exists

  Background:
    Given a directory named "git"
    And I initialize a git workspace in "git"
    And I cd to "git"

  @git.check.workspace.exists

  Scenario: Check that git workspace exists
    When I run `tau-cli git check workspace`
    Then the exit status should be 0

  @git.check.workspace.nogitworkspace

  Scenario: Check that no git workspace exists
    Given I cd to ".."
    When I run `tau-cli git check workspace`
    Then the exit status should be 1
