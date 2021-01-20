@docker
@docker.container
@docker.container.login

@before_build_mock_images

Feature: I can log in to a docker container

  Scenario: Log in to a docker container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage-mock
      docker_tag: prod
      """
    And I get the active takelage config
    When I successfully run `env -u TAKELAGE_PROJECT_BASE_DIR unbuffer tau-cli docker container login`
    Then the output should contain exactly "Running /loginpoint.py"

  Scenario: Do not log in to a takelage container from within a takelage container
    Given a file named "~/.takelage.yml" with:
      """
      ---
      docker_user: host.docker.internal:5005/takelage-mock
      docker_repo: takelage
      """
    And I get the active takelage config
    When I successfully run `env TAKELAGE_PROJECT_BASE_DIR='banana' unbuffer tau-cli docker container login`
    Then the output should contain:
      """
      [ERROR] You cannot log in to takelage from within takelage
      """
