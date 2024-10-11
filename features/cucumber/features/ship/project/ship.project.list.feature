@ship
@ship.project
@ship.project.list

@before_build_mock_images
@after_stop_mock_container

Feature: I can list takelship projects

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      """
    And I get the active takeltau config

  Scenario: List takelship projects
    Given I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer ship-cli project start`
    When I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer ship-cli project list`
    Then the output should contain "forgejo"
