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
      ship_container_check_matrjoschka: false
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      ship_ports_forgejo_server_http_33000: 54321
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
      """

  Scenario: Start the default project
    Given I successfully run `unbuffer ship-cli container clean`
    And the docker container "takelship_xeciz-vigoc" doesn't exist
    When I successfully run `unbuffer ship-cli project start`
    Then the docker container "takelship_xeciz-vigoc" exists
    And a file named "takelage.yml" should contain:
       """
       ship_ports_forgejo_server_http_33000: 54321
       """
