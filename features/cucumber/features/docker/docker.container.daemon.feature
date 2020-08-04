@docker
@docker.container
@docker.container.daemon

@before_build_mock_images

Feature: I can run a docker container in daemon mode

  Scenario: Run a docker container in daemon mode
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      """
    And I get the active takelage config
    And I successfully run `tau-cli clean`
    And the docker container "takelage-mock_cucumber" doesn't exist
    When I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer tau-cli docker container daemon`
    Then I successfully run `tau-cli docker container check exist takelage-mock_cucumber`
