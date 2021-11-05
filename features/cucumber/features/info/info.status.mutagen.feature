@info
@info.status
@info.status.mutagen

Feature: I can check if mutagen is available

  Scenario: Check that mutagen is available in a container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_check_daemon_start_daemon: $(exit 0)
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      mutagen_socket_path_mutagen_container: .
      """
    And I get the active takeltau config
    When I run `env TAKELAGE_PROJECT_BASE_DIR=. tau-cli info status mutagen`
    Then the exit status should be 0

  Scenario: Check that the mutagen socket is unavailable in a container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_check_daemon_start_daemon: $(exit 0)
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      mutagen_socket_path_mutagen_container: nonexisting
      """
    And I get the active takeltau config
    When I run `env TAKELAGE_PROJECT_BASE_DIR=. tau-cli info status mutagen`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] The mutagen socket path in the container is not available
      """

  Scenario: Check that the mutagen host connection is available in a container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_check_daemon_start_daemon: $(exit 0)
      cmd_mutagen_check_daemon_host_connection: $(exit 1)
      mutagen_socket_path_mutagen_container: .
      """
    And I get the active takeltau config
    When I run `env TAKELAGE_PROJECT_BASE_DIR=. tau-cli info status mutagen`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] A mutagen host connection is not available
      """

  Scenario: Check that mutagen is available on the host
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_check_daemon_start_daemon: $(exit 0)
      mutagen_socket_path_mutagen_host: .
      """
    And I get the active takeltau config
    When I run `env -u TAKELAGE_PROJECT_BASE_DIR tau-cli info status mutagen`
    Then the exit status should be 0

  Scenario: Check that mutagen is unavailable on the host
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_check_daemon_start_daemon: $(exit 1)
      """
    And I get the active takeltau config
    When I run `env -u TAKELAGE_PROJECT_BASE_DIR tau-cli info status mutagen`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] The mutagen daemon cannot be started
      """
