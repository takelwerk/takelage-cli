@docker
@docker.container
@docker.container.check
@docker.container.check.network

@before_build_mock_images

Feature: I can check if a docker network is existing

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      """
    And I get the active takeltau config

  Scenario: Check that an existing docker network is existing
    Given I successfully run `docker network create takelage-mock_test-network`
    When I successfully run `tau-cli docker container check network takelage-mock_test-network`
    Then I successfully run `docker network rm takelage-mock_test-network`

  Scenario: Check that a non-existing docker network is not existing
    Given I run `docker network rm takelage-mock_test-network`
    When I run `tau-cli docker container check network takelage-mock_nonexisting-name`
    Then the exit status should be 1
