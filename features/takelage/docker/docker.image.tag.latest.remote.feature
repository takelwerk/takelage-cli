@docker
@docker.image
@docker.image.tag
@docker.image.tag.latest
@docker.image.tag.latest.remote

@before_build_mock_images

Feature: I can print the latest remote docker tag

  Scenario: Print the latest remote docker tag
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_image: takelage-mock
      docker_repo: host.docker.internal:5005
      docker_tagsurl: http://host.docker.internal:5005/v2/takelage-mock/tags/list
      """
    And I get the active takelage config
    And I push the latest local docker image
    And I ask docker about the latest remote docker image
    When I successfully run `tau-cli docker image tag latest remote`
    Then the remote images match
