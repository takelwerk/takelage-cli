@docker
@docker.socket
@docker.socket.start

Feature: I can start gpg sockets

  Scenario: Start gpg sockets
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_socket_gpg_agent_port: 11111
      docker_socket_gpg_ssh_agent_port: 22222
      """
    And I get the active takelage config
    And I get the takelage docker socket start commands
    When I successfully run `tau-cli docker socket start`
    Then the gpg sockets are started
