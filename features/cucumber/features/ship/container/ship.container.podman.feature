@ship
@ship.container
@ship.container.podman

@before_build_mock_images
@after_stop_mock_takelship_container

Feature: I can run a podman command in a takelship container

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      ship_container_check_matrjoschka: false
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      ship_tag: latest
      cmd_ship_container_docker: echo banana
      """
    And I get the active takeltau config
    And a file named "takelship/compose/takelship.yml" with:
      """
      ---
      name: mockship
      docker_host: '28192'
      default_project: forgejo
      projects:
      - name: forgejo
        services:
        - name: forgejo-server
          ports:
          - port: 33000
            protocol: http
            description: my_description
      """

  Scenario: Run a podman command in a takelship container
    Given I successfully run `unbuffer ship-cli project start`
    When I successfully run `unbuffer ship-cli container podman ps`
    Then the output should contain "banana"

  Scenario: Run a podman command in a takelship container
    Given I successfully run `unbuffer ship-cli project start`
    When I successfully run `unbuffer ship-cli podman ps`
    Then the output should contain "banana"

  Scenario: Run a podman command in a takelship container
    Given I successfully run `unbuffer ship-cli project start`
    When I successfully run `unbuffer ship-cli docker ps`
    Then the output should contain "banana"
