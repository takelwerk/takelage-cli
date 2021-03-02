@git
@git.check
@git.check.main

Feature: I can check if I am on the git main branch

  Background:
    Given a directory named "git"
    And I initialize a git workspace in "git"
    And I cd to "git"

  @git.check.main.ismain

  Scenario: Check that I am on the git main branch
    When I run `tau-cli git check main`
    Then the exit status should be 0

  @git.check.main.isnotmain

  Scenario: Check that I am not on the git main branch
    Given I switch to the git branch named "my_branch" in "git"
    When I run `tau-cli git check main`
    Then the exit status should be 1

  @git.check.main.nogitworkspace

  Scenario: Assure that git workspace exists
    Given I cd to ".."
    When I run `tau-cli git check main`
    Then the exit status should be 1
