# frozen_string_literal: true

# takelage bit clipboard lib
module BitClipboardLib
  private

  # Run bit status.
  def _bit_clipboard_lib_bit_status
    log.debug 'Running bit status'

    cmd_bit_status = config.active['cmd_bit_clipboard_lib_bit_status']
    run cmd_bit_status
  end

  # Prepare workspace for bit clipboard.
  def _bit_clipboard_lib_prepare_workspace
    unless bit_check_workspace
      log.error 'No bit workspace'
      return false
    end

    return true unless git_check_workspace

    _bit_clipboard_lib_prepare_git_workspace
  end

  # Prepare git workspace for bit clipboard.
  def _bit_clipboard_lib_prepare_git_workspace
    unless git_check_master
      log.error 'Not on git master branch'
      return false
    end

    unless git_check_clean
      log.error 'No clean git workspace'
      return false
    end

    _bit_clipboard_lib_git_pull
  end

  # Remove bit artifacts.
  def _bit_clipbpard_lib_remove_bit_artifacts
    log.debug 'Removing bit artifacts'

    # Remove node_modules directory.
    FileUtils.remove_entry_secure('node_modules', force: true)

    # Remove index.bit files recursively.
    Dir.glob('./**/index.bit').each do |file|
      FileUtils.remove_entry_secure(file, force: true)
    end

    # Remove package.json file.
    FileUtils.remove_entry_secure('package.json', force: true)
  end

  # Sync workspace with upstream.
  def _bit_clipboard_lib_sync_workspace
    log.debug 'Syncing git workspace'

    path = config.active['project_root_dir']
    file = "#{path}/.bitmap"
    message = 'Update .bitmap'

    _bit_clipboard_lib_git_add file
    _bit_clipboard_lib_git_commit message
    _bit_clipboard_lib_git_push
  end

  # git add .bitmap.
  def _bit_clipboard_lib_git_add(file)
    log.debug "Adding \"#{file}\" to git"

    cmd_bit_clipboard_git_add = format(
      config.active['cmd_bit_clipboard_git_add'],
      file: file
    )
    run cmd_bit_clipboard_git_add
  end

  # git commit -m "Update .bitmap".
  def _bit_clipboard_lib_git_commit(message)
    log.debug "Committing to git with message \"#{message}\""

    cmd_bit_clipboard_git_commit = format(
      config.active['cmd_bit_clipboard_git_commit'],
      message: message
    )

    run cmd_bit_clipboard_git_commit
  end

  # git push origin master.
  def _bit_clipboard_lib_git_push
    log.debug 'Pushing master branch to origin'

    cmd_bit_clipboard_git_push =
      config.active['cmd_bit_clipboard_git_push']

    run cmd_bit_clipboard_git_push
  end

  # git pull.
  def _bit_clipboard_lib_git_pull
    log.debug 'Updating git workspace'
    cmd_bit_clipboard_git_pull =
      config.active['cmd_bit_clipboard_git_pull']

    return true if try cmd_bit_clipboard_git_pull

    log.error 'Unable to update git workspace'
    false
  end

  # Generate bit component ID.
  def _bit_clipboard_lib_id(name)
    id = ''

    # bit restrictions:
    # component names can only contain alphanumeric,
    # lowercase characters, and the following ["-", "_", "$", "!", "/"]

    # convert directory name to lowercase characters
    dir_downcase = name.downcase

    # construct array of allowed characters
    allowed_chars = [*('a'..'z'), *('0'..'9'), '-', '_', '$', '!', '/']

    # iterate over directory or file name
    # and replace invalid characters with underscore
    dir_downcase.split('').each do |char|
      id += allowed_chars.include?(char) ? char : '_'
    end

    log.debug "Generated bit id \"#{id}\" from \"#{name}\""
    id
  end
end
