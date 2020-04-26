@docker
@docker.image
@docker.image
@docker.image.check
@docker.image.check.outdated

@before_build_mock_images

Feature: I can check if a pinned image version is outdated

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      docker_registry: http://host.docker.internal:5005
      """
    And I get the active takelage config
    And I push the latest local docker image

  @docker.image.check.outdated.latest

  Scenario: Check latest docker tag version
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      docker_registry: http://host.docker.internal:5005
      docker_tag: latest
      """
    When I run `tau-cli docker image check outdated`
    Then the exit status should be 1

  @docker.image.check.outdated.uptodate

  Scenario: Check an up-to-date docker tag version
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      docker_registry: http://host.docker.internal:5005
      docker_tag: 0.1.0
      """
    When I run `tau-cli docker image check outdated`
    Then the exit status should be 1

  @docker.image.check.outdated.outdated

  Scenario: Check an outdated docker tag version
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      docker_registry: http://host.docker.internal:5005
      docker_tag: 0.0.3
      """
    When I run `tau-cli docker image check outdated`
    Then the exit status should be 0
