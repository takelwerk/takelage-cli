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
    And I cd to "project_clone"

  Scenario:
    When I successfully run `tau-cli hg pull`
    Then the file "my_hg_clone/new_file" should exist
