@info
@info.status
@info.status.mutagen

Feature: I can check if mutagen is available

  Scenario: Check that mutagen is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path: .
      cmd_mutagen_check_daemon_host_connection: $(exit 0)
      """
    And I get the active takelage config
    When I run `tau-cli info status mutagen`
    Then the exit status should be 0

  Scenario: Check that the mutagen socket is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path: nonexisting
      cmd_mutagen_check_daemon_host_connection: $(exit 0)
      """
    And I get the active takelage config
    When I run `tau-cli info status mutagen`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] mutagen socket is not available
      """

  Scenario: Check that the mutagen host connection is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path: .
      cmd_mutagen_check_daemon_host_connection: $(exit 1)
      """
    And I get the active takelage config
    When I run `tau-cli info status mutagen`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] mutagen host connection is not available
      """
