@bit
@bit.clipboard
@bit.clipboard.push

@after_remove_scope_my_scope

Feature: I can push a bit component changes to a bit remote scope

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
    And an empty file named "Rakefile"

  @bit.clipboard.push.dir

  Scenario: Push updates of a bit component to a bit remote scope
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
    And a file named "my_dir/my_file" with:
      """
      tomato
      """
    When I successfully run `tau-cli bit clipboard push`
    And I cd to ".."
    And a directory named "other"
    And I initialize a bit workspace in "other"
    And I cd to "other"
    And an empty file named "Rakefile"
    And I successfully run `tau-cli bit scope add my_scope`
    And I successfully run `tau-cli bit clipboard paste my_scope/my_dir my_dir`
    Then the file "my_dir/my_file" should match /tomato/

  @bit.clipboard.push.notongitmain

  Scenario: Fail if not on git main branch
    And I initialize a git workspace in "."
    And I switch to the git branch named "my_branch" in "."
    When I run `tau-cli bit clipboard push`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] Not on git main branch
      """
