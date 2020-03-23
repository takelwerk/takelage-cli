@docker
@docker.container
@docker.container.check
@docker.container.check.orphaned

@before_build_mock_images

Feature: I can check if a docker container is orphaned

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_image: takelage-mock
      docker_repo: host.docker.internal:5005
      """
    And I get the active takelage config

  @after_stop_mock_container

  Scenario: Check that an existing docker container is orphaned
    Given I successfully run `unbuffer tau-cli login`
    And I infinitize "/loginpoint.py" in "takelage-mock_cucumber"
    And I daemonize "/loginpoint.py" in "takelage-mock_cucumber"
    When I run `tau-cli docker container check orphaned takelage-mock_cucumber`
    Then the exit status should be 1

  Scenario: Check that a non-existing docker container doesn't exist
    Given I successfully run `unbuffer tau-cli login`
    When I run `tau-cli docker container check orphaned takelage-mock_cucumber`
    Then the exit status should be 0
