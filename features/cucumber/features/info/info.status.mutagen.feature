@info
@info.status
@info.status.mutagen

Feature: I can check if mutagen is available

  Scenario: Check that mutagen is available in a container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path_mutagen_container: .
      mutagen_socket_path_mutagen_host: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      """
    And I get the active takeltau config
    When I run `env TAKELAGE_PROJECT_BASE_DIR=. tau-cli info status mutagen`
    Then the exit status should be 0

  Scenario: Check that the mutagen socket is available in a container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path_mutagen_container: nonexisting
      mutagen_socket_path_mutagen_host: .
      cmd_mutagen_check_daemon_host_connection: $(exit 1)
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
      mutagen_socket_path_mutagen_container: .
      mutagen_socket_path_mutagen_host: .
      cmd_mutagen_check_daemon_host_connection: $(exit 1)
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
      mutagen_socket_path_mutagen_container: .
      mutagen_socket_path_mutagen_host: .
      cmd_mutagen_check_daemon_version: $(exit 0)
      """
    And I get the active takeltau config
    When I run `env -u TAKELAGE_PROJECT_BASE_DIR tau-cli info status mutagen`
    Then the exit status should be 0

  Scenario: Check that mutagen is unavailable on the host
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path_mutagen_container: .
      mutagen_socket_path_mutagen_host: .
      cmd_mutagen_check_daemon_version: $(exit 1)
      """
    And I get the active takeltau config
    When I run `env -u TAKELAGE_PROJECT_BASE_DIR tau-cli info status mutagen`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] The mutagen daemon is not available
      """
