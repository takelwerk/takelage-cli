@docker
@docker.container
@docker.container.list

@before_build_mock_images
@after_stop_mock_container

Feature: I can list docker containers

  Scenario: List docker containers
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_forward_socket_terminate: $(exit 0)
      cmd_mutagen_forward_socket_remove:
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      """
    And I get the active takeltau config
    And a directory named "finite"
    And a directory named "infinite"
    And I cd to "finite"
    And I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer tau-cli login`
    And I successfully run `tau-cli docker container check exist takelage-mock_finite_xucih-zavis`
    And I successfully run `tau-cli docker container check orphaned takelage-mock_finite_xucih-zavis`
    And I cd to "../infinite"
    And I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer tau-cli login`
    And I successfully run `tau-cli docker container check exist takelage-mock_infinite_xesoz-nivyr`
    And I infinitize "/loginpoint.py" in "takelage-mock_infinite_xesoz-nivyr"
    And I daemonize "/loginpoint.py" in "takelage-mock_infinite_xesoz-nivyr"
    And I run `tau-cli docker container check orphaned takelage-mock_infinite_xesoz-nivyr`
    And the exit status should be 1
    When I successfully run `tau-cli docker container list`
    Then the output should contain:
      """
      ---
      login:
        hosts:
        - takelage-mock_finite_xucih-zavis
      orphaned:
        hosts:
        - takelage-mock_infinite_xesoz-nivyr
      """

  Scenario: Do not list docker containers
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_forward_socket_terminate: $(exit 0)
      cmd_mutagen_forward_socket_remove:
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      """
    And I get the active takeltau config
    And I run `tau-cli docker container check exist takelage-mock_finite_xucih-zavis`
    And the exit status should be 1
    When I successfully run `tau-cli docker container list`
    Then the output should contain ""
