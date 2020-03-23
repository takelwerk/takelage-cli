@docker
@docker.container
@docker.container.purge

@before_build_mock_images
@after_stop_mock_container

Feature: I can purge docker containers

  Scenario: Purge docker containers
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_image: takelage-mock
      docker_repo: host.docker.internal:5005
      """
    And I get the active takelage config
    And a directory named "finite"
    And a directory named "infinite"
    And I cd to "finite"
    And I successfully run `unbuffer tau-cli login`
    And I successfully run `tau-cli docker container check exist takelage-mock_finite`
    And I successfully run `tau-cli docker container check orphaned takelage-mock_finite`
    And I cd to "../infinite"
    And I successfully run `unbuffer tau-cli login`
    And I successfully run `tau-cli docker container check exist takelage-mock_infinite`
    And I infinitize "/loginpoint.py" in "takelage-mock_infinite"
    And I daemonize "/loginpoint.py" in "takelage-mock_infinite"
    And I run `tau-cli docker container check orphaned takelage-mock_infinite`
    And the exit status should be 1
    When I successfully run `tau-cli docker container purge`
    And the docker container "takelage-mock_finite" doesn't exist
    And I successfully run `tau-cli docker container check exist takelage-mock_infinite`
