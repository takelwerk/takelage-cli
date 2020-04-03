@bit
@bit.clipboard
@bit.clipboard.pull

@after_remove_scope_my_scope

Feature: I can pull bit component changes to a local bit workspace

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

  @bit.clipboard.pull.dir

  Scenario: Pull bit component changes to a local bit workspace
    Given a directory named "my_dir"
    And a file named "my_dir/my_file" with:
      """
      banana
      """
    And the list of remote scopes is up-to-date
    But a remote scope named "my_scope" should not exist
    And I successfully run `tau-cli bit scope new my_scope`
    And I successfully run `tau-cli bit scope add my_scope`
    And I successfully run `tau-cli bit clipboard copy my_dir my_scope`
    And I cd to ".."
    And a directory named "other"
    And I initialize a bit workspace in "other"
    And I cd to "other"
    And I successfully run `tau-cli bit scope add my_scope`
    And I successfully run `tau-cli bit clipboard paste my_scope/my_dir my_dir`
    And I cd to "../bit"
    And a file named "my_dir/my_file" with:
      """
      tomato
      """
    And I successfully run `tau-cli bit clipboard push`
    And I cd to "../other"
    And the file "my_dir/my_file" should match /banana/
    When I successfully run `tau-cli bit clipboard pull`
    Then the file "my_dir/my_file" should match /tomato/

  @bit.clipboard.pull.dirwithbitignore

  Scenario: Pull bit component changes to a local bit workspace
    Given a directory named "my_dir"
    And an empty file named "my_dir/bitignore"
    And the list of remote scopes is up-to-date
    But a remote scope named "my_scope" should not exist
    And I successfully run `tau-cli bit scope new my_scope`
    And I successfully run `tau-cli bit scope add my_scope`
    And I successfully run `tau-cli bit clipboard copy my_dir my_scope`
    And I cd to ".."
    And a directory named "other"
    And I initialize a bit workspace in "other"
    And I cd to "other"
    And I successfully run `tau-cli bit scope add my_scope`
    And I successfully run `tau-cli bit clipboard paste my_scope/my_dir my_dir`
    And I remove the file "my_dir/.gitignore"
    And I cd to "../bit"
    And an empty file named "my_dir/my_file"
    And I successfully run `tau-cli bit clipboard push`
    And I cd to "../other"
    When I successfully run `tau-cli bit clipboard pull`
    Then the file "my_dir/my_file" should exist
    And the file "my_dir/bitignore" should exist
    And the file "my_dir/.gitignore" should contain:
      """
      *
      """

  @bit.clipboard.pull.notongitmaster

  Scenario: Fail if not on git master branch
    And I initialize a git workspace in "."
    And I switch to the git branch named "my_branch" in "."
    When I run `tau-cli bit clipboard pull`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] Not on git master branch
      """
