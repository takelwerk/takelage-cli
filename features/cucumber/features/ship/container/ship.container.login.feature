@ship
@ship.container
@ship.container.login

@before_build_mock_images
@after_stop_mock_takelship_container

Feature: I can log in to a takelship container

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      ship_container_check_matrjoschka: false
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      ship_tag: latest
      cmd_ship_container_login: whoami
      """
    And I get the active takeltau config
    And a file named "takelship/compose/takelship.yml" with:
      """
      ---
      """

  Scenario: Log in to a takelship container
    Given I successfully run `unbuffer ship-cli project start`
    When I successfully run `unbuffer ship-cli container login`
    Then the output should contain "root"
