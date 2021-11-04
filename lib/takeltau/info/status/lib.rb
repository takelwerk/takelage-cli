# frozen_string_literal: true

# tau info status lib
module InfoStatusLib
  private

  # Get git config user name
  def _info_status_lib_git_name(root)
    cmd_git_name =
      format(
        config.active['cmd_info_status_lib_git_name'],
        root: root
      )
    run cmd_git_name
  end

  # Get git config user email
  def _info_status_lib_git_email(root)
    cmd_git_email =
      format(
        config.active['cmd_info_status_lib_git_email'],
        root: root
      )
    run cmd_git_email
  end

  # Get git config user signingkey
  def _info_status_lib_git_signingkey(root)
    cmd_git_signingkey =
      format(
        config.active['cmd_info_status_lib_git_signingkey'],
        root: root
      )
    (run cmd_git_signingkey).chomp
  end

  # Check if git key is available
  def _info_status_lib_git_key_available(key)
    cmd_git_key_available =
      format(
        config.active['cmd_info_status_lib_git_key_available'],
        key: key
      )
    try cmd_git_key_available
  end

  # Get takelage environment string
  def _info_status_lib_get_channel_and_version
    takelage_version_file = '/etc/takelage_version'
    return '' unless _file_exists? takelage_version_file

    _file_read takelage_version_file

    channel = config.active['docker_repo']
    version = @content_file.chomp

    log.debug "#{channel}: #{version.green}"
    "#{channel}: #{version.green}"
  end
end
