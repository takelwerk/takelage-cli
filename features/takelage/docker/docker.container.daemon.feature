@docker
@docker.container
@docker.container.daemon

@before_build_mock_images

Feature: I can run a docker container in daemon mode

  Scenario: Run a docker container in daemon mode
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_image: takelage-mock
      docker_repo: host.docker.internal:5005
      """
    And I get the active takelage config
    And I successfully run `tau-cli nuke`
    And the docker container "takelage-mock_cucumber" doesn't exist
    When I successfully run `unbuffer tau-cli docker container daemon`
    Then I successfully run `tau-cli docker container check exist takelage-mock_cucumber`
