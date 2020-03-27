@bit
@bit.check
@bit.check.workspace

Feature: I can check if a git workspace exists

  Background:
    Given a directory named "bit"
    And I initialize a bit workspace in "bit"
    And I cd to "bit"

  @bit.check.workspace.exists

  Scenario: Check that bit workspace exists
    When I run `tau-cli bit check workspace`
    Then the exit status should be 0

  @bit.check.workspace.nogitworkspace

  Scenario: Check that no bit workspace exists
    Given I cd to ".."
    When I run `tau-cli bit check workspace`
    Then the exit status should be 1
