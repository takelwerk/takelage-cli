@bit
@bit.scope
@bit.scope.list

Feature: I can list bit remote scopes

  Scenario: List remote scopes
    Given a file named "~/.takelage.yml" with:
      """
      ---
      bit_remote: 'ssh://bit@bitboard-cucumber:222:/bit'
      bit_ssh: 'ssh -p 222 bit@bitboard-cucumber'
      """
    And I get the active takelage config
    And the list of remote scopes is up-to-date
    When I successfully run `tau-cli bit scope list`
    Then the output is equal to the list of remote scopes
