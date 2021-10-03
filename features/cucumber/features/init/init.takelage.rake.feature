@init
@init.takelage
@init.takelage.rake

@announce-stdout

Feature: I can initialize a takelage rake project

  Scenario: I initialize a takelage rake project
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_init_packer_lib_git_init: 'git init && git config user.name "Cucumber" && git config user.email "cucumber@example.com" && git checkout -b main'
      """
    And I get the active takeltau config
    And a directory named "project"
    And I cd to "project"
    When I run `tau-cli init takelage rake tomato`
    Then the exit status should be 0
    And the output should contain:
      """
      [INFO] Initializing git workspace
      """
    And the output should contain:
      """
      [INFO] Preparing initial git commit
      """
    And the output should contain:
      """
      [INFO] Saving initial git commit
      """
    And the file named "hgclone" should contain:
      """
      hg clone git@github.com:takelwerk/rake-meta.git rake/meta
      """
    And the file named ".gitignore" should contain:
      """
      takelage.yml
      """
    And the file named "project.yml" should contain:
      """
      tomato
      """
    And the file named "Rakefile" should contain:
      """
      load 'rake/meta/Rakefile'
      """
