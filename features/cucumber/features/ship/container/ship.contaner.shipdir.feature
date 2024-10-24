@ship
@ship.container
@ship.container.shipdir

@before_build_mock_images
@after_stop_mock_takelship_container

Feature: I can print the shipdir of a takelship container

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

  Scenario: Print a takelship shipdir if a takelship linked to the project root dir exists
    Given I successfully run `unbuffer ship-cli container clean`
    And the docker container "takelship_xeciz-vigoc" doesn't exist
    And I successfully run `unbuffer ship-cli project start`
    And the docker container "takelship_xeciz-vigoc" exists
    When I run `unbuffer ship-cli container shipdir`
    Then the exit status should be 0
    And the output should contain:
      """
      /tmp/cucumber
      """

  Scenario: Return false unless a takelship linked to the project root dir exists
    Given I successfully run `unbuffer ship-cli container clean`
    When I run `unbuffer ship-cli container shipdir`
    Then the exit status should be 1
    And the output should contain:
      """
      /tmp/cucumber
      """

  Scenario: Print a different takelship shipdir in a different directory
    Given a directory named "second"
    And I cd to "second"
    When I run `unbuffer ship-cli container shipdir`
    And the output should contain:
      """
      /tmp/cucumber/second
      """

  Scenario: Print a takelship directory from another directory via command line argument
    Given a directory named "second"
    And a directory named "third"
    And I cd to "third"
    When I run `unbuffer ship-cli -w ../second container shipdir`
    And the output should contain:
      """
      /tmp/cucumber/second
      """

  Scenario: Print a takelship directory from another directory via environment variable
    Given a directory named "second"
    And a directory named "third"
    And I cd to "third"
    When I run `unbuffer env TAKELAGE_WORKDIR=../second ship-cli container shipdir`
    And the output should contain:
      """
      /tmp/cucumber/second
      """
