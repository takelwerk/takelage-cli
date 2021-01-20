@bit
@bit.scope
@bit.scope.add

Feature: I can add bit remote scopes to workspaces

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

  @bit.scope.add.scope
  @after_remove_scope_my_scope

  Scenario: Add bit remote scope
    Given the list of remote scopes is up-to-date
    But a remote scope named "my_scope" should not exist
    And I successfully run `tau-cli bit scope new my_scope`
    And the list of remote scopes is up-to-date
    And the remote scope "my_scope" should exist
    But a local remote scope named "my_scope" in "bit" should not exist
    When I successfully run `tau-cli bit scope add my_scope`
    Then there is a local remote scope named "my_scope" in "bit"

  @bit.scope.add.notongitmain

  Scenario: Fail if not on git main branch
    And I initialize a git workspace in "."
    And I switch to the git branch named "my_branch" in "."
    When I run `tau-cli bit scope add nonexisting_scope`
    Then the exit status should be 1
    And the output should contain:
      """
      [ERROR] Not on git main branch
      """
