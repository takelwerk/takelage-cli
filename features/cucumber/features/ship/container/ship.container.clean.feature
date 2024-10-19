@ship
@ship.container
@ship.container.clean

@before_build_mock_images
@after_stop_mock_container

Feature: I can remove all takelship containers

  Scenario: Remove all takelship containers
    Given a file named "~/.takelage.yml" with:
      """
      ---
      ship_container_check_matrjoschka: false
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      """
    And I get the active takeltau config
    And a file named "takelship/compose/takelship.yml" with:
      """
      ---
      """
    And a file named "second/takelship/compose/projects/takelship.yml" with:
      """
      ---
      """
    And I run `docker ps`
    And I successfully run `unbuffer ship-cli project start`
    And I successfully run `ship-cli container check existing`
    And a directory "second"
    And I cd to "second"
    And I successfully run `unbuffer ship-cli project start`
    And I successfully run `ship-cli container check existing`
    When I successfully run `ship-cli container clean`
    Then I run `ship-cli container check existing`
    And the exit status should be 1
    And I cd to ".."
    And I run `ship-cli container check existing`
    And the exit status should be 1
