@mutagen
@mutagen.socket
@mutagen.socket.check

Feature: I can check a mutagen takelage socket

  Scenario: Check existing mutagen takelage socket
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path_mutagen_container: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      cmd_mutagen_forward_socket_check: $(exit 0)
      """
    And I get the active takeltau config
    When I run `tau-cli mutagen socket check "mysocket"`
    Then the exit status should be 0

  Scenario: Check non-existing mutagen takelage socket
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path_mutagen_container: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      cmd_mutagen_forward_socket_check: $(exit 1)
      """
    And I get the active takeltau config
    When I run `tau-cli mutagen socket check "mysocket"`
    Then the exit status should be 1
