@docker
@docker.image
@docker.image.tag
@docker.image.tag.list

@before_build_mock_images
@after_stop_mock_container

Feature: I can list the tags of docker images

  Scenario: List the tags of docker images
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      docker_registry: http://host.docker.internal:5005
      """
    And I get the active takeltau config
    And I ask docker about the docker images
    When I successfully run `tau-cli docker image tag list`
    Then the list of images match
