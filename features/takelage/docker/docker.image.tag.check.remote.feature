@docker
@docker.image
@docker.image.tag
@docker.image.tag.check
@docker.image.tag.check.remote

@before_build_mock_images

Feature: I can check a remote docker tag

  Scenario: Check an existing remote docker tag
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005
      docker_repo: takelage-mock
      docker_tagsurl: http://host.docker.internal:5005/v2/takelage-mock/tags/list
      """
    And I get the active takelage config
    And I push the latest local docker image
    When I run `tau-cli docker image tag check remote 0.1.0`
    Then the exit status should be 0

  Scenario: Check a non-existing remote docker tag
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005
      docker_repo: takelage-mock
      docker_tagsurl: http://host.docker.internal:5005/v2/takelage-mock/tags/list
      """
    When I run `tau-cli docker image tag check remote 0.2.0`
    Then the exit status should be 1
