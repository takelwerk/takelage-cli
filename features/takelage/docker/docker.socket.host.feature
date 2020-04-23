@docker
@docker.socket
@docker.socket.host

Feature: I can print the socket host ip address

  @docker.socket.host.localhost

  Scenario: Print socket host ip address without docker0 interface
    Given I delete a network device named "docker0"
    When I successfully run `tau-cli docker socket host`
    Then the output should contain "127.0.0.1"

  @docker.socket.host.docker0

  Scenario: Print socket host ip address with docker0 interface
    Given I create a network device named "docker0"
    When I successfully run `tau-cli docker socket host`
    Then the output should contain "10.0.111.222"
    And I delete a network device named "docker0"
