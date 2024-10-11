@ship
@ship.container
@ship.container.podman

@before_build_mock_images
@after_stop_mock_container

Feature: I can run a podman command in a takelship container

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      cmd_ship_container_podman: echo DOCKER_HOST=tcp://%{localhost}:%{docker_host} docker %{command}
      """
    And I get the active takeltau config

  Scenario: Run a podman command in a takelship container
    Given I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer ship-cli project start`
    When I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer ship-cli container podman ps`
    Then the output should contain "DOCKER_HOST=tcp://127.0.0.1:48192 docker ps"
