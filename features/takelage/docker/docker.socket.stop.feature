@docker
@docker.socket
@docker.socket.stop

Feature: I can stop gpg sockets

  Scenario: Stop gpg sockets
    Given I get the active takelage config
    And I get the takelage docker socket start commands
    When I successfully run `tau-cli docker socket stop`
    Then the gpg sockets are stopped