@mutagen
@mutagen.check
@mutagen.check.daemon

Feature: I can check if mutagene host connection available

  Scenario: Check existing mutagen socket path on the host
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_check_daemon_start_daemon: $(exit 0)
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      mutagen_socket_path_mutagen_host: .
      """
    And I get the active takeltau config
    When I run `env -u TAKELAGE_PROJECT_BASE_DIR tau-cli mutagen check daemon -l debug`
    Then the exit status should be 0

  Scenario: Check non-existing mutagen socket on the host
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_check_daemon_host_connection: $(exit 1)
      mutagen_socket_path_mutagen_host: nonexisting
      """
    And I get the active takeltau config
    When I run `env -u TAKELAGE_PROJECT_BASE_DIR tau-cli mutagen check daemon`
    Then the exit status should be 1
    And the output should contain "[ERROR] The mutagen socket path on the host is not available"

  Scenario: Check existing mutagen socket path in the container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      mutagen_socket_path_mutagen_container: .
      """
    And I get the active takeltau config
    When I run `env TAKELAGE_PROJECT_BASE_DIR=. tau-cli mutagen check daemon -l debug`
    Then the exit status should be 0

  Scenario: Check non-existing mutagen host connection in a container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_check_daemon_host_connection: $(exit 1)
      mutagen_socket_path_mutagen_container: nonexisting
      """
    And I get the active takeltau config
    When I run `env TAKELAGE_PROJECT_BASE_DIR=. tau-cli mutagen check daemon`
    Then the exit status should be 1
    And the output should contain "[ERROR] The mutagen socket path in the container is not available"

  Scenario: Start mutagen on the host
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_check_daemon_start_daemon: $(exit 0)
      mutagen_socket_path_mutagen_host: .
      """
    And I get the active takeltau config
    When I run `env -u TAKELAGE_PROJECT_BASE_DIR tau-cli mutagen check daemon`
    Then the exit status should be 0

  Scenario: Fail when mutagen start fails
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_check_daemon_start_daemon: $(exit 1)
      """
    And I get the active takeltau config
    When I run `tau-cli mutagen check daemon`
    Then the exit status should be 1
    And the output should contain "[ERROR] The mutagen daemon cannot be started"
