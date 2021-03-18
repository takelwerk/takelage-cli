@mutagen
@mutagen.socket
@mutagen.socket.create

Feature: I can create a mutagen takelage socket

  Scenario: Create mutagen takelage socket
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_forward_socket_create: echo "Created session"
      """
    And I get the active takelage config
    When I run `tau-cli mutagen socket create ~/.mutagen/daemon/daemon.sock ~/.mutagen/daemon/daemon.sock`
    Then the exit status should be 0

  Scenario: Fail to create a mutagen takelage socket
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_forward_socket_create: $(exit 1)
      """
    And I get the active takelage config
    When I run `tau-cli mutagen socket create nix.sock nix.sock`
    Then the exit status should be 1
