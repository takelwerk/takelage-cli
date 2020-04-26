@info
@info.project
@info.project.main

Feature: I can print the main project info

  Scenario: Print main project info
    Given a file named "~/.takelage.yml" with:
      """
      ---
      info_project_private: project_private.yml
      """
    And I get the active takelage config
    And a file named "project.yml" with:
      """
      ---
      project: test_info_project_main
      food: tomato
      """
    And a file named "project_private.yml" with:
      """
      ---
      project: test_info_project_private
      weather: fine
      """
    And an empty file named "Rakefile"
    When I successfully run `tau-cli info project active`
    Then the output should contain "project: test_info_project_private"
    And the output should contain "food: tomato"
    And the output should contain "weather: fine"
