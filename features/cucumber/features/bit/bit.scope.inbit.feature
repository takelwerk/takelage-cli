@bit
@bit.scope
@bit.scope.inbit

Feature: I can log in to remote server

  Scenario: Log in to remote server
    Given a file named "~/.takelage.yml" with:
      """
      ---
      bit_ssh: 'ssh -F $HOME/.ssh/config -p 222 bit@bitboard-cucumber exit 123'
      """
    And I get the active takelage config
    When I run `tau-cli bit scope inbit`
    Then the exit status should be 123

  Scenario: Handle absent config gracefully
    Given a file named "~/.takelage.yml" with:
      """
      ---
      bit_ssh:
      """
    And I get the active takelage config
    When I run `tau-cli bit scope inbit`
    And the output should contain:
      """
      [ERROR] Unset config key. Please configure "bit_ssh"
      """
