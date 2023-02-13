@info
@info.status
@info.status.arch

Feature: I can check the cpu architecture

  Scenario: Check an aarch64 architecture
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_arch_get_arch: echo aarch64
      """
    And I get the active takeltau config
    When I run `tau-cli info status arch`
    Then the exit status should be 0
    And the output should contain:
      """
      arm64
      """

  Scenario: Check an arm64 architecture
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_arch_get_arch: echo arm64
      """
    And I get the active takeltau config
    When I run `tau-cli info status arch`
    Then the exit status should be 0
    And the output should contain:
      """
      arm64
      """

  Scenario: Check an x86_64 architecture
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_arch_get_arch: echo x86_64
      """
    And I get the active takeltau config
    When I run `tau-cli info status arch`
    Then the exit status should be 0
    And the output should contain:
      """
      amd64
      """

  Scenario: Check an unknown architecture
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_arch_get_arch: echo banana
      """
    And I get the active takeltau config
    When I run `tau-cli info status arch`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] cpu architecture unknown
      """
