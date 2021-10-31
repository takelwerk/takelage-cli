@mutagen
@mutagen.check
@mutagen.check.daemon

Feature: I can check if mutagene host connection available

  Scenario: Check existing mutagen host connection in a container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_host_path_mutagen: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      """
    And I get the active takeltau config
    When I run `env TAKELAGE_PROJECT_BASE_DIR=. tau-cli mutagen check daemon -l debug`
    Then the exit status should be 0

  Scenario: Check non-existing mutagen socket in a container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_container_path_mutagen: nonexisting
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      """
    And I get the active takeltau config
    When I run `env TAKELAGE_PROJECT_BASE_DIR=. tau-cli mutagen check daemon`
    Then the exit status should be 1

  Scenario: Check non-existing mutagen host connection in a container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_host_path_mutagen: .
      cmd_mutagen_check_daemon_host_connection: $(exit 1)
      """
    And I get the active takeltau config
    When I run `env TAKELAGE_PROJECT_BASE_DIR=. tau-cli mutagen check daemon`
    Then the exit status should be 1

  Scenario: Check existing mutagen version on the host
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_check_daemon_version: $(exit 0)
      """
    And I get the active takeltau config
    When I run `env -u TAKELAGE_PROJECT_BASE_DIR tau-cli mutagen check daemon`
    Then the exit status should be 0

  Scenario: Check non-existing mutagen version on the host
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path_mutagen: .
      cmd_mutagen_check_daemon_version: $(exit 1)
      """
    And I get the active takeltau config
    When I run `env -u TAKELAGE_PROJECT_BASE_DIR tau-cli mutagen check daemon`
    Then the exit status should be 1

  Scenario: Check if the test "is mutagen available?" works
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_host_path_mutagen: .
      cmd_mutagen: 'banana'
      """
    And I get the active takeltau config
    When I run `env -u TAKELAGE_PROJECT_BASE_DIR tau-cli mutagen check daemon`
    Then the exit status should be 1
