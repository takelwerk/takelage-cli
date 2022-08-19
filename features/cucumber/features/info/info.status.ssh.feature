@info
@info.status
@info.status.ssh

Feature: I can check if ssh is available

  Scenario: Check that ssh is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_ssh_socket: echo /tmp
      cmd_info_status_ssh_keys: $(exit 0)
      """
    And I get the active takeltau config
    When I run `env SSH_AUTH_SOCK='/tmp' tau-cli info status ssh`
    Then the exit status should be 0

  Scenario: Check that the ssh uses gpg ssh socket
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_ssh_socket: echo /tmp
      """
    And I get the active takeltau config
    When I run `env SSH_AUTH_SOCK='/nonexisting' tau-cli info status ssh`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] ssh does not use gpg ssh socket
      """

  Scenario: Check that the gpg ssh socket is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_ssh_socket: echo /nonexisting
      cmd_info_status_ssh_keys: $(exit 0)
      """
    And I get the active takeltau config
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
      cmd_info_status_ssh_socket: echo /tmp
      cmd_info_status_ssh_keys: $(exit 1)
      """
    And I get the active takeltau config
    When I run `env SSH_AUTH_SOCK='/tmp' tau-cli info status ssh`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] ssh keys are not available
      """
