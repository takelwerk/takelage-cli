@docker
@docker.image
@docker.image.tag
@docker.image.tag.list
@docker.image.tag.list.local

@before_build_mock_images

Feature: I can list the tags of local docker images

  Scenario: List the tags of local docker images
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      docker_registry: http://host.docker.internal:5005
      """
    And I get the active takelage config
    And I ask docker about the local docker images
    When I successfully run `tau-cli docker image tag list local`
    Then the list of local images match
