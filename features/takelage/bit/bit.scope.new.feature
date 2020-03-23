@bit
@bit.scope
@bit.scope.new

@after_remove_scope_my_scope

Feature: I can add a bit remote scopes

  Scenario: Add remote scope
    Given a file named "~/.takelage.yml" with:
      """
      ---
      bit_remote: 'ssh://bit@host.docker.internal:2022:/bit'
      bit_ssh: 'ssh -p 2022 bit@host.docker.internal'
      """
    And I get the active takelage config
    And the list of remote scopes is up-to-date
    And a remote scope named "my_scope" should not exist
    When I successfully run `tau-cli bit scope new my_scope`
    Then the list of remote scopes is up-to-date
    And there is a remote scope named "my_scope"
