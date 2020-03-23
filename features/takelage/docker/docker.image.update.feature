@docker
@docker.image
@docker.image.update

@before_build_mock_images

Feature: I can update locally to the latest remote docker container

  Scenario: Update locally to the latest remote docker container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_image: takelage-mock
      docker_repo: host.docker.internal:5005
      docker_tagsurl: http://host.docker.internal:5005/v2/takelage-mock/tags/list
      """
    And I get the active takelage config
    And I push the latest local docker image
    And I remove the latest local docker image
    When I successfully run `tau-cli docker image update`
    Then my latest local docker version matches the latest remote docker version
