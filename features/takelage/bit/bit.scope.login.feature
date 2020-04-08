@bit
@bit.scope
@bit.scope.login

Feature: I can list bit remote scopes

  Scenario: List remote scopes
    Given a file named "~/.takelage.yml" with:
      """
      ---
      bit_remote: 'ssh://bit@bitboard-cucumber:222:/bit'
      bit_ssh: 'ssh -F $HOME/.ssh/config -p 222 bit@bitboard-cucumber exit 123'
      """
    And I get the active takelage config
    When I run `tau-cli bit scope login`
    Then the exit status should be 123
