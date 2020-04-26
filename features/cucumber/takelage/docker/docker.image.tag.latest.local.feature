@docker
@docker.image
@docker.image.tag
@docker.image.tag.latest
@docker.image.tag.latest.local

@before_build_mock_images

Feature: I can print the latest local docker tag

  Scenario: Print the latest local docker tag
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      docker_registry: http://host.docker.internal:5005
      """
    And I get the active takelage config
    And I ask docker about the latest local docker image
    When I successfully run `tau-cli docker image tag latest local`
    Then the local images match
