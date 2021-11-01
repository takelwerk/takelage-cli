@info
@info.status
@info.status.hg

Feature: I can check if hg is configured

  Scenario: Check that hg is configured
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_hg_username: $(exit 0)
      """
    When I run `tau-cli info status hg`
    Then the exit status should be 0

  Scenario: Check that git name is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_hg_username: $(exit 1)
      """
    When I run `tau-cli info status hg`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] hg ui.username is not configured
      """
