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
      docker_image: takelage-mock
      docker_repo: host.docker.internal:5005
      docker_tagsurl: http://host.docker.internal:5005/v2/takelage-mock/tags/list
      """
    And I get the active takelage config
    And I ask docker about the local docker images
    When I successfully run `tau-cli docker image tag list local`
    Then the list of local images match
