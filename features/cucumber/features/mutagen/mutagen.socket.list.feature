@mutagen
@mutagen.socket
@mutagen.socket.list

Feature: I can list mutagen takelage sockets

  Scenario: List existing mutagen takelage sockets
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path_mutagen: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      cmd_mutagen_forward_socket_list: echo bosek-sonax
      """
    And I get the active takeltau config
    When I run `tau-cli mutagen socket list`
    Then the exit status should be 0

  Scenario: List non-existing mutagen takelage sockets
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path_mutagen: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      cmd_mutagen_forward_socket_list:
      """
    And I get the active takeltau config
    When I run `tau-cli mutagen socket list`
    Then the exit status should be 1
