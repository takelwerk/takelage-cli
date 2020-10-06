@info
@info.project
@info.project.pass

Feature: I can resolve a pass call in the main project file

  Background:
    Given I initialize a gopass workspace

  Scenario: Print main project info
    Given a file named "project.yml" with:
      """
      ---
      my_test_pass: pass(test_key)
      """
    And an empty file named "Rakefile"
    When I successfully run `tau-cli info project main`
    Then the output should contain "my_test_pass: test_value"
