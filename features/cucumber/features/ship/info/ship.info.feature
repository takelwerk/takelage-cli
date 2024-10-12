@ship
@ship.info

@before_build_mock_images
@after_stop_mock_container

Feature: I can get info about a takelship container

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      """
    And I get the active takeltau config
    And a file named "takelship/compose/projects/takelship.yml" with:
      """
      ---
      name: mockship
      docker_host: '48192'
      default_project: forgejo
      projects:
      - name: forgejo
        services:
        - forgejo-server: {}
      """

  Scenario: Get yaml info about a takelship container
    Given I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer ship-cli project start`
    When I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer ship-cli info yaml`
    Then the output should contain "name: mockship"

  Scenario: Get json info about a takelship container
    Given I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer ship-cli project start`
    When I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer ship-cli info json`
    Then the output should contain "\"name\":\"mockship\""
