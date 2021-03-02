@info
@info.status
@info.status.ssh

Feature: I can check if ssh is available

  Scenario: Check that ssh is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_docker_socket_config_agent_ssh_socket_path: echo /tmp
      cmd_info_status_ssh_keys: $(exit 0)
      """
    And I get the active takelage config
    When I run `env SSH_AUTH_SOCK='/tmp' tau-cli info status ssh`
    Then the exit status should be 0

  Scenario: Check that the ssh socket is well configured
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_docker_socket_config_agent_ssh_socket_path: echo /tmp
      """
    And I get the active takelage config
    When I run `tau-cli info status ssh`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] gpg ssh socket is misconfigured
      """

  Scenario: Check that the ssh keys are available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_docker_socket_config_agent_ssh_socket_path: echo /nonexisting
      """
    And I get the active takelage config
    When I run `env SSH_AUTH_SOCK='/nonexisting' tau-cli info status ssh`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] gpg ssh socket is not available
      """

  Scenario: Check that the ssh keys are available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_docker_socket_config_agent_ssh_socket_path: echo /tmp
      cmd_info_status_ssh_keys: $(exit 1)
      """
    And I get the active takelage config
    When I run `env SSH_AUTH_SOCK='/tmp' tau-cli info status ssh`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] ssh keys are not available
      """
