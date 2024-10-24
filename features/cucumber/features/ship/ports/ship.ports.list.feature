@ship
@ship.ports
@ship.ports.list

@before_build_mock_images
@after_stop_mock_takelship_container

Feature: I can list the ports of a takelship container

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      ship_container_check_matrjoschka: false
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      ship_tag: latest
      ship_name: takelship-mock
      ship_ports_portainer_http_39000: 33333
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
        - name: portainer
          ports:
          - port: 39000
            protocol: http
        - name: forgejo-server
          ports:
          - port: 33000
            protocol: http
      """

  Scenario: Get info about a takelship container
    Given I successfully run `unbuffer ship-cli container clean`
    And I successfully run `unbuffer ship-cli project start`
    When I successfully run `env TAKELAGE_TAU_CONFIG_SHIP_PORTS_FORGEJO_SERVER_HTTP_33000=33099 unbuffer ship-cli ports list`
    Then the output should contain "ship_ports_docker_host_docker_28192"
    And the output should contain:
      """
      ship_ports_forgejo_server_http_33000:
        service: forgejo-server
        protocol: http
        takelship: 33000
        localhost: 33099
      """
    And the output should contain:
      """
      ship_ports_portainer_http_39000:
        service: portainer
        protocol: http
        takelship: 39000
        localhost: 33333
      """
