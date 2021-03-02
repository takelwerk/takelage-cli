@info
@info.status
@info.status.gopass

Feature: I can check if gopass is available

  Scenario: Check that gopass is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 0)
      """
    And I get the active takelage config
    When I run `tau-cli info status gopass`
    Then the exit status should be 0

  Scenario: Check that gopass root store is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_gopass_root_store: echo
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 0)
      """
    And I get the active takelage config
    When I run `tau-cli info status gopass`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] gopass root store not found
      """

  Scenario: Check that gopass root store signing key is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 1)
      """
    And I get the active takelage config
    When I run `tau-cli info status gopass`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] gopass root store gpg key is not available
      """
