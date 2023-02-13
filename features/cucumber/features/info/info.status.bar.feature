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
      cmd_info_status_arch_get_arch: echo x86_64
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      cmd_info_status_hg_username: $(exit 0)
      cmd_info_status_ssh_keys: $(exit 0)
      docker_repo: takelbanana
      mutagen_socket_path_mutagen_container: .
      mutagen_socket_path_mutagen_host: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      """
    And I get the active takeltau config
    And an empty file named "Rakefile"
    When I successfully run `env SSH_AUTH_SOCK='/tmp' tau-cli info status bar`
    Then the output should contain:
      """
      arch: amd64 | git: ok | gopass: ok | gpg: ok | hg: ok | ssh: ok | mutagen: ok
      """
    And the output should contain:
      """
      takelbanana:
      """

  Scenario: Check an unknown takelage cpu architecture
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_ssh_socket: echo /tmp
      cmd_info_status_lib_git_name: echo name
      cmd_info_status_lib_git_email: echo email
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 0)
      cmd_info_status_arch_get_arch: echo banana
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      cmd_info_status_hg_username: $(exit 0)
      cmd_info_status_ssh_keys: $(exit 0)
      mutagen_socket_path_mutagen_host: .
      mutagen_socket_path_mutagen_container: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      """
    And I get the active takeltau config
    And an empty file named "Rakefile"
    When I run `env SSH_AUTH_SOCK='/tmp' tau-cli info status bar`
    Then the exit status should be 1
    And the output should contain:
      """
      arch: unknown | git: ok | gopass: ok | gpg: ok | hg: ok | ssh: ok | mutagen: ok
      """
    And the output should contain:
      """
      [ERROR] cpu architecture unknown
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
      cmd_info_status_arch_get_arch: echo x86_64
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      cmd_info_status_hg_username: $(exit 0)
      cmd_info_status_ssh_keys: $(exit 0)
      mutagen_socket_path_mutagen_host: .
      mutagen_socket_path_mutagen_container: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      """
    And I get the active takeltau config
    And an empty file named "Rakefile"
    When I run `env SSH_AUTH_SOCK='/tmp' tau-cli info status bar`
    Then the exit status should be 1
    And the output should contain:
      """
      arch: amd64 | git: no | gopass: no | gpg: ok | hg: ok | ssh: ok | mutagen: ok
      """
    And the output should contain:
      """
      [ERROR] git config user.signingkey is not available
      """

  Scenario: Check the takelage hg status
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_ssh_socket: echo /tmp
      cmd_info_status_lib_git_name: echo name
      cmd_info_status_lib_git_email: echo email
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 0)
      cmd_info_status_arch_get_arch: echo x86_64
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      cmd_info_status_hg_username: $(exit 1)
      cmd_info_status_ssh_keys: $(exit 0)
      mutagen_socket_path_mutagen_host: .
      mutagen_socket_path_mutagen_container: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      """
    And I get the active takeltau config
    And an empty file named "Rakefile"
    When I run `env SSH_AUTH_SOCK='/tmp' tau-cli info status bar`
    Then the exit status should be 1
    And the output should contain:
      """
      arch: amd64 | git: ok | gopass: ok | gpg: ok | hg: no | ssh: ok | mutagen: ok
      """
    And the output should contain:
      """
      [ERROR] hg ui.username is not configured
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
      cmd_info_status_arch_get_arch: echo x86_64
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      cmd_info_status_hg_username: $(exit 0)
      cmd_info_status_ssh_keys: $(exit 1)
      mutagen_socket_path_mutagen_host: .
      mutagen_socket_path_mutagen_container: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      """
    And I get the active takeltau config
    And an empty file named "Rakefile"
    When I run `env SSH_AUTH_SOCK='/nonexisting' tau-cli info status bar`
    Then the exit status should be 1
    And the output should contain:
      """
      arch: amd64 | git: ok | gopass: ok | gpg: ok | hg: ok | ssh: no | mutagen: ok
      """
    And the output should contain:
      """
      [ERROR] ssh does not use gpg ssh socket
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
      cmd_info_status_arch_get_arch: echo x86_64
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      cmd_info_status_hg_username: $(exit 0)
      cmd_info_status_ssh_keys: $(exit 1)
      mutagen_socket_path_mutagen_host: .
      mutagen_socket_path_mutagen_container: .
      cmd_mutagen_check_daemon_host_connection: 'echo Status: Forwarding connections'
      """
    And I get the active takeltau config
    And an empty file named "Rakefile"
    When I run `env SSH_AUTH_SOCK='/tmp' tau-cli info status bar`
    Then the exit status should be 1
    And the output should contain:
      """
      arch: amd64 | git: ok | gopass: ok | gpg: ok | hg: ok | ssh: no | mutagen: ok
      """
    And the output should contain:
      """
      [ERROR] ssh keys are not available
      """

  Scenario: Check the takelage mutagen no forwarding connections
    Given a file named "~/.takelage.yml" with:
      """
      ---
      cmd_info_status_ssh_socket: echo /tmp
      cmd_info_status_lib_git_name: echo name
      cmd_info_status_lib_git_email: echo email
      cmd_info_status_lib_git_signingkey: echo signingkey
      cmd_info_status_lib_git_key_available: $(exit 0)
      cmd_info_status_arch_get_arch: echo x86_64
      cmd_info_status_gopass_root_store: echo root
      cmd_info_status_gpg_agent: $(exit 0)
      cmd_info_status_gpg_keys: $(exit 0)
      cmd_info_status_hg_username: $(exit 0)
      cmd_info_status_ssh_keys: $(exit 1)
      mutagen_socket_path_mutagen_host: .
      mutagen_socket_path_mutagen_container: .
      cmd_mutagen_check_daemon_host_connection: $(exit 1)
      """
    And I get the active takeltau config
    And an empty file named "Rakefile"
    When I run `env SSH_AUTH_SOCK='/tmp' tau-cli info status bar`
    Then the exit status should be 1
    And the output should contain:
      """
      arch: amd64 | git: ok | gopass: ok | gpg: ok | hg: ok | ssh: no | mutagen: no
      """
    And the output should contain:
      """
      [ERROR] A mutagen host connection is not available
      """
