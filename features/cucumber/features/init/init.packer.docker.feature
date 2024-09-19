@init
@init.packer
@init.packer.docker

@announce-stdout

Feature: I can initialize a packer project for docker images

  Scenario: I initialize a packer project for docker images
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_init_packer_lib_git_init: 'git init && git config user.name "Cucumber" && git config user.email "cucumber@example.com" && git checkout -b main'
      """
    And I get the active takeltau config
    And a directory named "project"
    And I cd to "project"
    When I run `tau-cli init packer docker banana`
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
    And the file named "ansible/group_vars/all/project.yml" should contain:
      """
      project: "{{ lookup('pipe', 'cd /project && tau project') | from_yaml }}"
      """
    And the file named "ansible/playbook-site.yml" should contain:
      """
      (playbook-site)
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
      banana
      """
    And the file named "Rakefile" should contain:
      """
      load 'rake/meta/Rakefile'
      """
