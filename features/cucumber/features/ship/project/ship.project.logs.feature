@ship
@ship.project
@ship.project.logs

@before_build_mock_images
@after_stop_mock_container

Feature: I can print the logs of a takelship container

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_ship_project_follow_logs: 'echo follow the logs'
      ship_container_check_matrjoschka: false
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      """
    And I get the active takeltau config
    And a file named "takelship/compose/takelship.yml" with:
      """
      ---
      """

  Scenario: Print logs of a takelship container
    Given I successfully run `unbuffer ship-cli project start`
    When I successfully run `unbuffer ship-cli project logs`
    Then the output should contain "follow the logs"
