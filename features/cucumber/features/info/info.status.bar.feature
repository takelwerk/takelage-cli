@info
@info.status
@info.status.bar

Feature: I can check the takelage status

  Background:
    Given a directory named "project"
    And I initialize a git workspace in "project"
    And I cd to "project"
    And an empty file named "Rakefile"

  Scenario: Print the takelage status bar
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_ssh_socket: echo /tmp
      cmd_info_status_lib_git_name: echo name
      cmd_info_status_lib_git_email: echo email
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 0)
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      cmd_info_status_ssh_keys: $(exit 0)
      mutagen_socket_path_mutagen: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      """
    And I get the active takelage config
    And an empty file named "Rakefile"
    When I run `env SSH_AUTH_SOCK='/tmp' tau-cli info status bar`
    Then the output should contain:
      """
      git: ok | gopass: ok | gpg: ok | mutagen: ok | ssh: ok
      """

  Scenario: Check the takelage git and gopass status
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_ssh_socket: echo /tmp
      cmd_info_status_lib_git_name: echo name
      cmd_info_status_lib_git_email: echo email
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 1)
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      cmd_info_status_ssh_keys: $(exit 0)
      mutagen_socket_path_mutagen: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      """
    And I get the active takelage config
    And an empty file named "Rakefile"
    When I run `env SSH_AUTH_SOCK='/tmp' tau-cli info status bar`
    Then the output should contain:
      """
      git: no | gopass: no | gpg: ok | mutagen: ok | ssh: ok
      """

  Scenario: Check the takelage ssh socket status
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_ssh_socket: echo /tmp
      cmd_info_status_lib_git_name: echo name
      cmd_info_status_lib_git_email: echo email
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 0)
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      cmd_info_status_ssh_keys: $(exit 1)
      mutagen_socket_path_mutagen: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      """
    And I get the active takelage config
    And an empty file named "Rakefile"
    When I run `env SSH_AUTH_SOCK='/nonexisting' tau-cli info status bar`
    Then the output should contain:
      """
      git: ok | gopass: ok | gpg: ok | mutagen: ok | ssh: no
      """

  Scenario: Check the takelage ssh keys status
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_ssh_socket: echo /tmp
      cmd_info_status_lib_git_name: echo name
      cmd_info_status_lib_git_email: echo email
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 0)
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      cmd_info_status_ssh_keys: $(exit 1)
      mutagen_socket_path_mutagen: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      """
    And I get the active takelage config
    And an empty file named "Rakefile"
    When I run `env SSH_AUTH_SOCK='/tmp' tau-cli info status bar`
    Then the output should contain:
      """
      git: ok | gopass: ok | gpg: ok | mutagen: ok | ssh: no
      """

  Scenario: Check the takelage mutagen no forwardin connections
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_ssh_socket: echo /tmp
      cmd_info_status_lib_git_name: echo name
      cmd_info_status_lib_git_email: echo email
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 0)
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      cmd_info_status_ssh_keys: $(exit 1)
      mutagen_socket_path_mutagen: .
      cmd_mutagen_check_daemon_host_connection: $(exit 1)
      """
    And I get the active takelage config
    And an empty file named "Rakefile"
    When I run `env SSH_AUTH_SOCK='/tmp' tau-cli info status bar`
    Then the output should contain:
      """
      git: ok | gopass: ok | gpg: ok | mutagen: no | ssh: no
      """
