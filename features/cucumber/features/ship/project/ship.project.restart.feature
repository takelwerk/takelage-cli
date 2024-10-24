@ship
@ship.project
@ship.project.restart

@before_build_mock_images
@after_stop_mock_takelship_container

Feature: I can restart a takelship project

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

  Scenario: Restart the default project
    Given I successfully run `unbuffer ship-cli container clean`
    And the docker container "takelship_xeciz-vigoc" doesn't exist
    And I successfully run `unbuffer ship-cli project start`
    And the output should contain:
      """
      localhost:54321 [forgejo-server http]     (my_description)
      """
    And the docker container "takelship_xeciz-vigoc" exists
    Given a file named "takelage.yml" with:
      """
      ---
      ship_container_check_matrjoschka: false
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      ship_tag: latest
      ship_ports_forgejo_server_http_33000: 12345
      """
    When I successfully run `unbuffer ship-cli project restart`
    Then the output should contain:
      """
      Stopped takelship takelship_xeciz-vigoc
      """
    And the output should contain:
      """
      The takelship takelship_xeciz-vigoc
      departed from /tmp/cucumber
      ships project forgejo
      """
    And the output should contain:
      """
      localhost:54321 [forgejo-server http]     (my_description)
      """
    And the docker container "takelship_xeciz-vigoc" exists
