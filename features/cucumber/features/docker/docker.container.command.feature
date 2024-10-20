@docker
@docker.container
@docker.container.command

@before_build_mock_images
@after_stop_mock_container

Feature: I can run a command in a docker container

  Scenario: Run a command in a docker container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_container_check_matrjoschka: false
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      """
    And I get the active takeltau config
    And I successfully run `unbuffer tau-cli docker container login`
    And I create my user in the docker container
    When I successfully run `unbuffer tau-cli docker container command pwd`
    Then the output should contain "/project"
