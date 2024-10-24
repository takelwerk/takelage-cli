@ship
@ship.container
@ship.container.check
@ship.container.check.existing

@before_build_mock_images
@after_stop_mock_takelship_container

Feature: I can check if a takelship container is existing

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      ship_container_check_matrjoschka: false
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      ship_tag: latest
      """
    And I get the active takeltau config
    And a file named "takelship/compose/takelship.yml" with:
      """
      ---
      """

  Scenario: Check that an existing takelship container is existing
    Given I successfully run `unbuffer ship-cli project start`
    When I run `ship-cli container check existing`
    Then the exit status should be 0
    And I run `ship-cli project stop`

  Scenario: Check that a non-existing takelship container is not existing
    Given the docker container "takelship_xeciz-vigoc" doesn't exist
    When I run `ship-cli container check existing`
    Then the exit status should be 1
