@info
@info.status
@info.status.git

Feature: I can check if git is available

  Background:
    Given a directory named "project"
    And I initialize a git workspace in "project"
    And I cd to "project"
    And an empty file named "Rakefile"

  Scenario: Check that git is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_lib_git_name: echo name
      cmd_info_status_lib_git_email: echo email
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 0)
      """
    And I get the active takeltau config
    When I run `tau-cli info status git`
    Then the exit status should be 0

  Scenario: Check that project root dir is available
    Given I remove the file "Rakefile"
    When I run `tau-cli info status git`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] Cannot determine project root directory
      [WARN] Is there a Rakefile in the project root directory?
      """

  Scenario: Check that project root dir is git workspace
    Given I cd to ".."
    And an empty file named "Rakefile"
    When I run `tau-cli info status git`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] Project root directory is not a git workspace
      """

  Scenario: Check that git name is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_lib_git_name: echo
      cmd_info_status_lib_git_email: echo email
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 0)
      """
    And I get the active takeltau config
    When I run `tau-cli info status git`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] git config user.name is not available
      """

  Scenario: Check that git name is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_lib_git_name: echo name
      cmd_info_status_lib_git_email: echo
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 0)
      """
    And I get the active takeltau config
    When I run `tau-cli info status git`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] git config user.email is not available
      """

  Scenario: Check that git signingkey is available
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_lib_git_name: echo name
      cmd_info_status_lib_git_email: echo email
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 1)
      """
    And I get the active takeltau config
    When I run `tau-cli info status git`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] git config user.signingkey is not available
      """
