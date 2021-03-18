@mutagen
@mutagen.socket
@mutagen.socket.terminate

Feature: I can terminate a mutagen takelage socket

  Scenario: Terminate mutagen takelage socket
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_forward_socket_terminate: $(exit 0)
      cmd_mutagen_forward_socket_remove:
      """
    And I get the active takelage config
    When I run `tau-cli mutagen socket terminate bosek-sonax`
    Then the exit status should be 0

  Scenario: Fail to terminate a mutagen takelage socket
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_forward_socket_terminate: $(exit 1)
      """
    And I get the active takelage config
    When I run `tau-cli mutagen socket terminate nix`
    Then the exit status should be 1
