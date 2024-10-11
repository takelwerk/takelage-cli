@ship
@ship.container
@ship.container.login

@before_build_mock_images
@after_stop_mock_container

Feature: I can log in to a takelship container

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      cmd_ship_container_login: whoami
      """
    And I get the active takeltau config

  Scenario: Log in to a takelship container
    Given I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer ship-cli project start`
    When I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer ship-cli container login`
    Then the output should contain "root"
