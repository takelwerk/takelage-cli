@docker
@docker.image
@docker.image.update

@before_build_mock_images

Feature: I can update to the latest remote docker image

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      docker_registry: http://host.docker.internal:5005
      """
    And I get the active takelage config
    And I push the local docker image "latest"

  @docker.image.update.nolocalimageexists

  Scenario: Download latest remote docker image if no local image available
    Given I remove all local docker images
    When I successfully run `tau-cli docker image update`
    Then my latest local docker version should be "latest"

  @docker.image.update.onlylatestimageexists

  Scenario: Download latest remote docker image if no local image available
    Given I remove all local docker images but not "latest"
    When I successfully run `tau-cli docker image update`
    Then my latest local docker version should be "latest"