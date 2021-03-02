@info
@info.status
@info.status.gpg

Feature: I can check if gpg is available

  Scenario: Check that the gpg is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      """
    And I get the active takelage config
    When I run `tau-cli info status gpg`
    Then the exit status should be 0

  Scenario: Check that the gpg agent is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_gpg_agent: $(exit 1)
      cmd_info_status_gpg_keys: $(exit 0)
      """
    And I get the active takelage config
    When I run `tau-cli info status gpg`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] GPG agent is not available
      """


  Scenario: Check that the gpg keys are available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 1)
      """
    And I get the active takelage config
    When I run `tau-cli info status gpg`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] GPG keys are not available
      """
