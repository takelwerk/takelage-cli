@docker
@docker.image
@docker.image.tag
@docker.image.tag.latest

@before_build_mock_images
@after_stop_mock_container

Feature: I can print the latest docker tag

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      docker_registry: http://host.docker.internal:5005
      """
    And I get the active takeltau config

  Scenario: Print the docker tag "latest"
    Then my latest docker image should be "latest"

  Scenario: Print the latest numerical docker tag
    Given I remove the latest docker image
    Then my latest docker image should be "0.1.0"
