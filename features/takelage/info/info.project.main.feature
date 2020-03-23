@info
@info.project
@info.project.main

Feature: I can print the main project info

  Scenario: Print main project info
    Given a file named "project.yml" with:
      """
      ---
      project: test_info_project_main
      """
    And an empty file named "Rakefile"
    When I successfully run `tau-cli info project main`
    Then the output should contain "project: test_info_project_main"
