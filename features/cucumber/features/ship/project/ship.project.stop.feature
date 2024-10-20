@ship
@ship.project
@ship.project.stop

@before_build_mock_images
@after_stop_mock_container

Feature: I can stop a takelship project

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

  Scenario: Start the default project
    Given I successfully run `unbuffer ship-cli project start`
    And the docker container "takelship_xeciz-vigoc" exists
    When I successfully run `unbuffer ship-cli project stop`
    Then the docker container "takelship_xeciz-vigoc" doesn't exist
    And the output should contain:
      """
      Stopped takelship "takelship_xeciz-vigoc"
      """
