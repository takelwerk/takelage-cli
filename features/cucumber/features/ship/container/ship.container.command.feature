@ship
@ship.container
@ship.container.command

@before_build_mock_images
@after_stop_mock_container

Feature: I can run a command in a takelship container

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      ship_container_check_matrjoschka: false
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      cmd_ship_container_docker: echo podman
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

  Scenario: Run a run command in a takelship container
    Given I successfully run `unbuffer ship-cli project start`
    When I successfully run `unbuffer ship-cli container command whoami`
    Then the output should contain "podman"
