@ship
@ship.project
@ship.project.stop

@before_build_mock_images
@after_stop_mock_container

Feature: I can stop a takelship project

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      """
    And I get the active takeltau config

  Scenario: Start the default project
    Given I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer ship-cli project start`
    And the docker container "takelship_xeciz-vigoc" exists
    When I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer ship-cli project stop`
    Then the docker container "takelship_xeciz-vigoc" doesn't exist
