@git
@git.check
@git.check.master

Feature: I can check if I am on the git master branch

  Background:
    Given a directory named "git"
    And I initialize a git workspace in "git"
    And I cd to "git"

  @git.check.master.ismaster

  Scenario: Check that I am on the git master branch
    When I run `tau-cli git check master`
    Then the exit status should be 0

  @git.check.master.isnotmaster

  Scenario: Check that I am not on the git master branch
    Given I switch to the git branch named "my_branch" in "git"
    When I run `tau-cli git check master`
    Then the exit status should be 1

  @git.check.master.nogitworkspace

  Scenario: Assure that git workspace exists
    Given I cd to ".."
    When I run `tau-cli git check master`
    Then the exit status should be 1
