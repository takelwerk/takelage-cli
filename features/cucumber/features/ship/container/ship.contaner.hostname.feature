@ship
@ship.container
@ship.container.hostname

@before_build_mock_images
@after_stop_mock_takelship_container

Feature: I can print the hostname of a takelship container

  Background:
    Given a file named "takelage.yml" with:
      """
      ---
      ship_container_check_matrjoschka: false
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      ship_tag: latest
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
            description: my_description
      """

  Scenario: Print a takelship hostname if a takelship linked to the project root dir exists
    Given I successfully run `unbuffer ship-cli container clean`
    And the docker container "takelship_xeciz-vigoc" doesn't exist
    And I successfully run `unbuffer ship-cli project start`
    And the docker container "takelship_xeciz-vigoc" exists
    When I run `unbuffer ship-cli container hostname`
    Then the exit status should be 0
    And the output should contain:
      """
      takelship_xeciz-vigoc
      """

  Scenario: Do not print a takelship hostname if no takelship linked to the project root dir exists
    Given I successfully run `unbuffer ship-cli container clean`
    When I run `unbuffer ship-cli container hostname`
    Then the exit status should be 1
    And the output should contain:
      """
      takelship_xeciz-vigoc
      """
