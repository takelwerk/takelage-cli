@ship
@ship.project
@ship.project.create

@before_build_mock_images
@after_stop_mock_container

Feature: I can create takelship projects

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
      ---
      name: mockship
      docker_host: '28192'
      default_project: forgejo
      projects:
      - name: forgejo
        services:
        - name: forgejo-server
          ports:
          - port: 33000
            protocol: http
            description: my_description
      """

  Scenario: Create a takelship project
    Given I successfully run `unbuffer ship-cli project start`
    When I successfully run `unbuffer ship-cli project create`
    Then the output should contain "Created takelship project \"forgejo\"."

  Scenario: Update a takelship project
    Given I successfully run `unbuffer ship-cli project start`
    When I successfully run `unbuffer ship-cli project update`
    Then the output should contain "Updated takelship project \"forgejo\"."
