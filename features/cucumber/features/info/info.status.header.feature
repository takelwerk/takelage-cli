@info
@info.status
@info.status.header

Feature: I can check the takelage status

  Scenario: Check the takelage status
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_docker_socket_config_agent_ssh_socket_path: echo /tmp
      cmd_info_status_lib_git_name: echo name
      cmd_info_status_lib_git_email: echo email
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 0)
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      cmd_info_status_ssh_keys: $(exit 0)
      """
    And I get the active takelage config
    And an empty file named "Rakefile"
    When I run `tau-cli info status header`
    Then the output should contain:
      """
      git: ok | gopass: ok | gpg: ok | ssh: ok
      """

  Scenario: Check the takelage git and gopass status
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_docker_socket_config_agent_ssh_socket_path: echo /tmp
      cmd_info_status_lib_git_name: echo name
      cmd_info_status_lib_git_email: echo email
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 1)
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      cmd_info_status_ssh_keys: $(exit 0)
      """
    And I get the active takelage config
    And an empty file named "Rakefile"
    When I run `tau-cli info status header`
    Then the output should contain:
      """
      git: no | gopass: no | gpg: ok | ssh: ok
      """

  Scenario: Check the takelage ssh status
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_docker_socket_config_agent_ssh_socket_path: echo /tmp
      cmd_info_status_lib_git_name: echo name
      cmd_info_status_lib_git_email: echo email
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 0)
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      cmd_info_status_ssh_keys: $(exit 1)
      """
    And I get the active takelage config
    And an empty file named "Rakefile"
    When I run `tau-cli info status header`
    Then the output should contain:
      """
      git: ok | gopass: ok | gpg: ok | ssh: no
      """
