@git
@git.check
@git.check.hg

Feature: I can check if I am on the git hg branch

  Background:
    Given a directory named "git"
    And I initialize a git workspace in "git"
    And I cd to "git"

  @git.check.hg.ishg

  Scenario: Check that I am on the git hg branch
    When I run `tau-cli git check hg`
    Then the exit status should be 0

  @git.check.hg.isnothg

  Scenario: Check that I am not on the git hg branch
    Given I switch to the git branch named "my_branch" in "git"
    When I run `tau-cli git check hg`
    Then the exit status should be 1

  @git.check.hg.nogitworkspace

  Scenario: Assure that git workspace exists
    Given I cd to ".."
    When I run `tau-cli git check hg`
    Then the exit status should be 1
