@git
@git.check
@git.check.bit

Feature: I can check if I am on the git bit branch

  Background:
    Given a directory named "git"
    And I initialize a git workspace in "git"
    And I cd to "git"

  @git.check.bit.isbit

  Scenario: Check that I am on the git bit branch
    When I run `tau-cli git check bit`
    Then the exit status should be 0

  @git.check.bit.isnotbit

  Scenario: Check that I am not on the git bit branch
    Given I switch to the git branch named "my_branch" in "git"
    When I run `tau-cli git check bit`
    Then the exit status should be 1

  @git.check.bit.nogitworkspace

  Scenario: Assure that git workspace exists
    Given I cd to ".."
    When I run `tau-cli git check bit`
    Then the exit status should be 1
