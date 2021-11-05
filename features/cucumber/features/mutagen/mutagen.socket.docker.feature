@mutagen
@mutagen.socket
@mutagen.socket.docker

Feature: I can create a mutagen docker socket

  Scenario: Create mutagen docker socket
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path_mutagen_container: .
      mutagen_socket_path_mutagen_host: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      cmd_mutagen_forward_socket_docker: echo "Created session"
      """
    And I get the active takeltau config
    When I run `tau-cli mutagen socket docker ~/.docker.sock`
    Then the exit status should be 0

  Scenario: Fail to create a mutagen docker socket
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path_mutagen_container: .
      mutagen_socket_path_mutagen_host: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      cmd_mutagen_forward_socket_docker: $(exit 1)
      """
    And I get the active takeltau config
    When I run `tau-cli mutagen socket create nix.sock`
    Then the exit status should be 1
