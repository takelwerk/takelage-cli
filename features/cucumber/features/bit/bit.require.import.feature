@bit
@bit.require
@bit.require.import

Feature: I can import bit components from a requirements file

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      bit_remote: 'ssh://bit@bitboard-cucumber:222:/bit'
      bit_ssh: 'ssh -F $HOME/.ssh/config -p 222 bit@bitboard-cucumber'
      """
    And I get the active takeltau config
    And a directory named "export"
    And I initialize a bit workspace in "export"
    And I cd to "export"
    And an empty file named "Rakefile"
    And a directory named "my_dir"
    And an empty file named "my_dir/my_file"
    And the list of remote scopes is up-to-date
    But a remote scope named "my_scope" should not exist
    And I successfully run `tau-cli bit scope new my_scope`
    And I successfully run `tau-cli bit scope add my_scope`
    And I successfully run `tau-cli bit clipboard copy my_dir my_scope`
    And the list of remote scopes is up-to-date
    And the remote scope "my_scope" should exist
    And I cd to ".."
    And there is a bit component named "my_dir" in the remote scope named "my_scope" in "export"
    And a directory named "project"
    And I initialize a git workspace in "project"
    And I initialize a bit workspace in "project"
    And I cd to "project"
    And I successfully run `tau-cli bit scope add my_scope`

  @bit.require.import.implicitpath
  @after_remove_scope_my_scope

  Scenario: Import a bit component with implicit path
    Given a file named "bitrequire.yml" with:
      """
      ---
      scopes:
        my_scope:
        - name: my_dir
      """
    And an empty file named "Rakefile"
    And I commit everything in "project" to git
    When I successfully run `tau-cli bit require import`
    Then the directory "my_dir" should exist
    And the file "my_dir/my_file" should exist

  @bit.require.import.explicitpath
  @after_remove_scope_my_scope

  Scenario: Import a bit component with explicit path
    Given a file named "bitrequire.yml" with:
      """
      ---
      scopes:
        my_scope:
        - name: my_dir
          path: my_other_dir
      """
    And an empty file named "Rakefile"
    And I commit everything in "project" to git
    When I successfully run `tau-cli bit require import`
    Then the directory "my_other_dir" should exist
    And the file "my_other_dir/my_file" should exist

  @bit.require.import.idempotent
  @after_remove_scope_my_scope

  Scenario: Do not import a bit component twice
    Given a file named "bitrequire.yml" with:
      """
      ---
      scopes:
        my_scope:
        - name: my_dir
      """
    And an empty file named "Rakefile"
    And I commit everything in "project" to git
    And I successfully run `tau-cli bit require import`
    And I commit everything in "project" to git
    When I successfully run `tau-cli bit require import`
    Then the directory "my_dir" should exist
    And the file "my_dir/my_file" should exist
    And the output should contain:
      """
      [WARN] Skipping existing bit component "my_scope/my_dir" with path "/tmp/cucumber/project/my_dir"
      """
