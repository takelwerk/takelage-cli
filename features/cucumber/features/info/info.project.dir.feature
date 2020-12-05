@info
@info.project
@info.project.dir

Feature: I can print the project root directory

  Scenario: Print project root directory
    Given an empty file named "Rakefile"
    When I successfully run `tau-cli info project dir`
    Then the output should contain exactly:
    """
    /tmp/cucumber
    """
