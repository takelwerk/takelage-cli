@mutagen
@mutagen.socket
@mutagen.socket.list

Feature: I can list mutagen takelage sockets

  Scenario: List existing mutagen takelage sockets
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_forward_socket_list: echo bosek-sonax
      """
    And I get the active takelage config
    When I run `tau-cli mutagen socket list`
    Then the exit status should be 0

  Scenario: List non-existing mutagen takelage sockets
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_forward_socket_list:
      """
    And I get the active takelage config
    When I run `tau-cli mutagen socket list`
    Then the exit status should be 1
