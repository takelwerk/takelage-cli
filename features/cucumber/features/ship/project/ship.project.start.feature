@ship
@ship.project
@ship.project.start

@before_build_mock_images
@after_stop_mock_container

Feature: I can start a takelship project

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

  Scenario: Start the default project
    Given I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer ship-cli project stop`
    And the docker container "takelship_xeciz-vigoc" doesn't exist
    When I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer ship-cli project start`
    Then the docker container "takelship_xeciz-vigoc" exists
