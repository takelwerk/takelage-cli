@docker
@docker.image
@docker.image.tag
@docker.image.tag.check
@docker.image.tag.check.local

@before_build_mock_images

Feature: I can check a local docker tag

  Scenario: Check an existing local docker tag
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_image: takelage-mock
      docker_repo: host.docker.internal:5005
      docker_tagsurl: http://host.docker.internal:5005/v2/takelage-mock/tags/list
      """
    When I run `tau-cli docker image tag check local 0.1.0`
    Then the exit status should be 0

  Scenario: Check a non-existing local docker tag
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_image: takelage-mock
      docker_repo: host.docker.internal:5005
      docker_tagsurl: http://host.docker.internal:5005/v2/takelage-mock/tags/list
      """
    When I run `tau-cli docker image tag check local 0.2.0`
    Then the exit status should be 1
