@mutagen
@mutagen.socket
@mutagen.socket.create

Feature: I can create a mutagen takelage socket

  Scenario: Create mutagen socket
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_host_path_mutagen: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      cmd_mutagen_forward_socket_create: echo "Created session"
      """
    And I get the active takeltau config
    When I run `tau-cli mutagen socket create mutagen-socket ~/.mutagen/daemon/daemon.sock ~/.mutagen/daemon/daemon.sock`
    Then the exit status should be 0

  Scenario: Fail to create a mutagen socket
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_host_path_mutagen: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      cmd_mutagen_forward_socket_create: $(exit 1)
      """
    And I get the active takeltau config
    When I run `tau-cli mutagen socket create nix.sock nix.sock`
    Then the exit status should be 1
