@ship
@ship.container
@ship.container.update

@before_build_mock_images

Feature: I can update to the latest remote takelship image

  Background:
    Given a file named "~/.takelage.yml" with:
      """
      ---
      ship_user: host.docker.internal:5005/takelage-mock
      ship_repo: takelship-mock
      ship_tag: latest
      docker_registry: http://host.docker.internal:5005
      """
    And I get the active takeltau config
    And I push the takelship image

  Scenario: Download latest remote takelship image if no local image available
    Given I remove the takelship image
    When I successfully run `ship-cli container update`
    Then I downloaded the takelship image
