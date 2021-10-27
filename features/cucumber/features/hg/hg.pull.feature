@hg
@hg.pull

Feature: I can pull hg repos

  Background:
    Given a directory named "my_git_origin"
    And I initialize a git workspace in "my_git_origin"
    And an empty file named "my_git_origin/my_file"
    And I commit everything in "my_git_origin" to git
    And a directory named "project_origin"
    And I initialize a git workspace in "project_origin"
    And an empty file named "project_origin/Rakefile"
    And I commit everything in "project_origin" to git
    And I run `git clone project_origin project_clone`
    And I run `hg clone my_git_origin project_clone/my_hg_clone`
    And I commit everything in "project_clone" to git
    And an empty file named "my_git_origin/new_file"
    And I commit everything in "my_git_origin" to git
    And I switch to the new git branch named "my_branch" in "project_origin"
    And I cd to "project_clone"

  Scenario: Pull hg repo
    When I successfully run `tau-cli hg pull`
    Then the file "my_hg_clone/new_file" should exist

  Scenario: Fail when not on git hg branch
    Given I switch to the new git branch named "my_branch" in "project_clone"
    When I run `tau-cli hg pull`
    Then the exit status should be 1
    And the output should contain "[ERROR] Not on git hg branch"

  Scenario: Fail when git sees uncommitted files
    Given an empty file named "uncommitted_file"
    When I run `tau-cli hg pull`
    Then the exit status should be 1
    And the output should contain "[ERROR] No clean git workspace"

  Scenario: Fail when git cannot pull from upstream
    Given I successfully run `git remote remove origin`
    When I run `tau-cli hg pull`
    Then the exit status should be 1
    And the output should contain "[ERROR] Unable to pull git workspace"

  Scenario: Fail when hg pull fails
    Given the directory "../my_git_origin" does not exist
    When I run `tau-cli hg pull`
    Then the exit status should be 1
    And the output should contain "[ERROR] Unable to tau hg pull"

  Scenario: Fail when final git push fails
    Given I successfully run `git remote set-url --push origin banana`
    When I run `tau-cli hg pull`
    Then the exit status should be 1
    And the output should contain "[ERROR] Unable to git push .hg mercurial directories"
