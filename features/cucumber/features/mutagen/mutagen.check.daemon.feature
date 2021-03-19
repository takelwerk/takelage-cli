@mutagen
@mutagen.check
@mutagen.check.daemon

Feature: I can check if mutagene host connection available

  Scenario: Check existing mutagen host connection in a container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path: .
      cmd_mutagen_check_daemon_host_connection: $(exit 0)
      """
    And I get the active takelage config
    When I run `env TAKELAGE_PROJECT_BASE_DIR=. tau-cli mutagen check daemon`
    Then the exit status should be 0

  Scenario: Check non-existing mutagen socket in a container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path: nonexisting
      cmd_mutagen_check_daemon_host_connection: $(exit 0)
      """
    And I get the active takelage config
    When I run `env TAKELAGE_PROJECT_BASE_DIR=. tau-cli mutagen check daemon`
    Then the exit status should be 1

  Scenario: Check non-existing mutagen host connection in a container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path: .
      cmd_mutagen_check_daemon_host_connection: $(exit 1)
      """
    And I get the active takelage config
    When I run `env TAKELAGE_PROJECT_BASE_DIR=. tau-cli mutagen check daemon`
    Then the exit status should be 1

  Scenario: Check existing mutagen version on the host
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_check_daemon_version: $(exit 0)
      """
    And I get the active takelage config
    When I run `env -u TAKELAGE_PROJECT_BASE_DIR tau-cli mutagen check daemon`
    Then the exit status should be 0

  Scenario: Check non-existing mutagen version on the host
    Given a file named "~/.takelage.yml" with:
      """
      ---
      mutagen_socket_path: .
      cmd_mutagen_check_daemon_version: $(exit 1)
      """
    And I get the active takelage config
    When I run `env -u TAKELAGE_PROJECT_BASE_DIR tau-cli mutagen check daemon`
    Then the exit status should be 1
