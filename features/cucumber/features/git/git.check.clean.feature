@git
@git.check
@git.check.clean

Feature: I can check if a git workspace is clean

  Background:
    Given a directory named "git"
    And I initialize a git workspace in "git"
    And I cd to "git"

  @git.check.clean.isclean

  Scenario: Check that git workspace is clean
    When I run `tau-cli git check clean`
    Then the exit status should be 0

  @git.check.clean.isunstaged

  Scenario: Check that git workspace has unstaged changes
    Given an empty file named "my_file"
    When I run `tau-cli git check clean`
    Then the exit status should be 1

  @git.check.clean.isuncommitted

  Scenario: Check that git workspace has uncommitted changes
    Given an empty file named "my_file"
    And I successfully run `git add --all`
    When I run `tau-cli git check clean`
    Then the exit status should be 1

  @git.check.clean.nogitworkspace

  Scenario: Assure that git workspace exists
    Given I cd to ".."
    When I run `tau-cli git check clean`
    Then the exit status should be 1
