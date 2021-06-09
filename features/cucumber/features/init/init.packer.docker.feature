@init
@init.packer
@init.packer.docker

@announce-stdout

Feature: I can initialize a packer project for docker images

  cmd_init_packer_lib_git_init
  Scenario: I initialize a packer project for docker images
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_init_packer_lib_git_init: 'git init && git config user.name "Cucumber" && git config user.email "cucumber@example.com" && git checkout -b main'
      init_packer_docker_bit_require_import: 'false'
      """
    And I get the active takelage config
    And I configure my global bit report settings
    And a directory named "project"
    And I cd to "project"
    When I run `tau-cli init packer docker banana -l debug`
    Then the exit status should be 0
    And the output should contain:
      """
      [INFO] Saving initial git commit
      """
