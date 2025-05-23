@ship
@ship.container
@ship.container.list

@before_build_mock_images
@after_stop_mock_takelship_container

Feature: I can list takelship containers

  Scenario: List takelship containers
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
    And I successfully run `unbuffer ship-cli project start`
    And I successfully run `ship-cli container check existing`
    When I successfully run `ship-cli container list`
    Then the output should contain:
      """
      ---
      takelship:
        hosts:
        - takelship_xeciz-vigoc: "/tmp/cucumber/takelship"
      """
