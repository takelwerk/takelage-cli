@docker
@docker.check
@docker.check.daemon

Feature: I can check if the docker daemon is running

  Scenario: Check that the docker daemon is running
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_docker_check_daemon_info: $(exit 0)
      """
    And I get the active takeltau config
    When I run `tau-cli docker check daemon`
    Then the exit status should be 0

  Scenario: Check that the docker daemon is not running
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_docker_check_daemon_info: $(exit 1)
      """
    And I get the active takeltau config
    When I run `tau-cli docker check daemon`
    Then the exit status should be 1

  Scenario: Check if the test "is docker available?" works
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_docker: 'banana'
      docker_container_check_matrjoschka: false
      """
    And I get the active takeltau config
    When I run `tau-cli docker check daemon`
    Then the exit status should be 1
