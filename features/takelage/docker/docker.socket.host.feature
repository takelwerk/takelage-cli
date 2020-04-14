@docker
@docker.socket
@docker.socket.host

Feature: I can print the socket host ip address

  Scenario: Print socket host ip address without docker0 interface
    Given I run `ip link show dev docker0`
    And the exit status should be 1
    When I successfully run `tau-cli docker socket host`
    Then the output should contain "127.0.0.1"

  Scenario: Print socket host ip address with docker0 interface
    Given I run `ip link show dev docker0`
    And the exit status should be 1
    And I successfully run `sudo ip link add dev docker0 type veth`
    And I successfully run `sudo ip addr add 10.0.111.222/24 dev docker0`
    When I successfully run `tau-cli docker socket host`
    Then the output should contain "10.0.111.222"
    And I successfully run `sudo ip link delete docker0`
