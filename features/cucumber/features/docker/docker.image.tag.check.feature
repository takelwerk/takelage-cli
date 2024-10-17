@docker
@docker.image
@docker.image.tag
@docker.image.tag.check

@before_build_mock_images
@after_stop_mock_container

Feature: I can check a docker tag

  Scenario: Check an existing docker tag
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      docker_registry: http://host.docker.internal:5005
      """
    When I run `tau-cli docker image tag check 0.1.0`
    Then the exit status should be 0

  Scenario: Check a non-existing docker tag
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      docker_registry: http://host.docker.internal:5005
      """
    When I run `tau-cli docker image tag check 0.2.0`
    Then the exit status should be 1
