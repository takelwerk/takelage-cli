@mutagen
@mutagen.socket
@mutagen.socket.tidy

Feature: I can remove mutagen daemon files

  Scenario: Fail to remove mutagen daemon files when remove command is empty
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_mutagen_forward_socket_remove:
      cmd_docker_container_check_existing_docker_ps: $(exit 0)
      """
    And I get the active takeltau config
    When I run `tau-cli mutagen socket tidy`
    Then the exit status should be 1

  Scenario: Fail to remove mutagen daemon files when container does not exist
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_docker_container_check_existing_docker_ps: $(exit 1)
      """
    And I get the active takeltau config
    When I run `tau-cli mutagen socket tidy -l debug`
    Then the exit status should be 1
    And the output should contain:
      """
      [DEBUG] Container
      """
    And the output should contain:
      """
      is not existing
      """
