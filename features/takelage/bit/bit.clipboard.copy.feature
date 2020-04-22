@bit
@bit.clipboard
@bit.clipboard.copy

@after_remove_scope_my_scope

Feature: I can copy a directory as a new tagged bit component

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      bit_remote: 'ssh://bit@bitboard-cucumber:222:/bit'
      bit_ssh: 'ssh -F $HOME/.ssh/config -p 222 bit@bitboard-cucumber'
      """
    And I get the active takelage config
    And a directory named "bit"
    And I initialize a bit workspace in "bit"
    And I cd to "bit"

  @bit.clipboard.copy.dir
  @bit.clipboard.copy.dir.noreadmebit

  Scenario: Add directory without README.bit and export it
    Given a directory named "my_dir"
    But the file "my_dir/README.bit" should not exist
    And the list of remote scopes is up-to-date
    But a remote scope named "my_scope" should not exist
    And I successfully run `tau-cli bit scope new my_scope`
    And I successfully run `tau-cli bit scope add my_scope`
    When I successfully run `tau-cli bit clipboard copy my_dir my_scope -l debug`
    Then the output should contain:
      """
      [INFO] Creating "README.bit" in "my_dir"
      """
    And the file "my_dir/README.bit" should exist
    And the directory "node_modules" should not exist
    And there is a bit component named "my_dir" in the remote scope named "my_scope" in "bit"

  @bit.clipboard.copy.dir
  @bit.clipboard.copy.dir.readmebit

  Scenario: Add directory with README.bit and export it
    Given a directory named "my_dir"
    And an empty file named "my_dir/README.bit"
    And the list of remote scopes is up-to-date
    But a remote scope named "my_scope" should not exist
    And I successfully run `tau-cli bit scope new my_scope`
    And I successfully run `tau-cli bit scope add my_scope`
    When I successfully run `tau-cli bit clipboard copy my_dir my_scope`
    Then the output should not contain "[WARN]"
    And the directory "node_modules" should not exist
    And there is a bit component named "my_dir" in the remote scope named "my_scope" in "bit"

  @bit.clipboard.copy.dir
  @bit.clipboard.copy.dir.nestedreadmebits

  Scenario: Do not add directory with nested README.bit
    Given a directory named "my_dir"
    And an empty file named "my_dir/README.bit"
    And a directory named "my_dir/my_subdir"
    And an empty file named "my_dir/my_subdir/README.bit"
    And the list of remote scopes is up-to-date
    But a remote scope named "my_scope" should not exist
    And I successfully run `tau-cli bit scope new my_scope`
    And I successfully run `tau-cli bit scope add my_scope`
    When I run `tau-cli bit clipboard copy my_dir my_scope`
    Then the exit status should be 1
    And the output should contain "[ERROR] Nested README.bit file detected"

  @bit.clipboard.copy.file

  Scenario: Do not add a file as a new tagged bit component
    Given an empty file named "my_file"
    When I run `tau-cli bit clipboard copy my_file nonexisting_scope`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] The directory "my_file" does not exist
      """

  @bit.clipboard.copy.notongitmaster

  Scenario: Fail if not on git master branch
    And I initialize a git workspace in "."
    And I switch to the git branch named "my_branch" in "."
    When I run `tau-cli bit clipboard copy nonexisting_dir nonexisting_scope`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] Not on git master branch
      """
