# frozen_string_literal: true

# takelage info status lib
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
    run cmd_git_signingkey
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

end
