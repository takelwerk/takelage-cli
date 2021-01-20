@docker
@docker.check
@docker.check.socat

Feature: I can check if the socat command is available

  Scenario: Check that the socat command is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_docker_check_socat_socat_version: $(exit 0)
      """
    And I get the active takelage config
    When I run `tau-cli docker check socat`
    Then the exit status should be 0

  Scenario: Check that the socat command is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_docker_check_socat_socat_version: $(exit 1)
      """
    And I get the active takelage config
    When I run `tau-cli docker check socat`
    Then the exit status should be 1
