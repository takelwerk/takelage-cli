@docker
@docker.container
@docker.container.check
@docker.container.check.orphaned

@before_build_mock_images
@after_stop_mock_container

Feature: I can check if a docker container is orphaned

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      """
    And I get the active takeltau config

  Scenario: Check that an orphaned docker container is orphaned
    Given I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer tau-cli login`
    And I successfully run `tau-cli docker container check existing takelage-mock_cucumber_xinot-syzof`
    When I run `tau-cli docker container check orphaned takelage-mock_cucumber_xinot-syzof`
    Then the exit status should be 0

  Scenario: Check that a non-orphaned docker container isn't orphaned
    Given I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer tau-cli login`
    And I infinitize "/loginpoint.py" in "takelage-mock_cucumber_xinot-syzof"
    And I daemonize "/loginpoint.py" in "takelage-mock_cucumber_xinot-syzof"
    When I run `tau-cli docker container check orphaned takelage-mock_cucumber_xinot-syzof`
    Then the exit status should be 1
