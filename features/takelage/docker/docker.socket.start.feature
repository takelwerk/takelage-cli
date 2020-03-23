@docker
@docker.socket
@docker.socket.start

Feature: I can start gpg sockets

  Scenario: Start gpg sockets
    Given I get the active takelage config
    And I get the takelage docker socket start commands
    When I successfully run `tau-cli docker socket start`
    Then the gpg sockets are started