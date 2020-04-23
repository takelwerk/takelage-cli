# frozen_string_literal: true

# takelage bit clipboard lib
module BitClipboardLib
  private

  # Prepare workspace for bit clipboard.
  # rubocop:disable Metrics/MethodLength
  def _bit_clipboard_lib_prepare_workspace
    unless bit_check_workspace
      log.error 'No bit workspace'
      return false
    end

    if git_check_workspace
      unless git_check_master
        log.error 'Not on git master branch'
        return false
      end

      unless git_check_clean
        log.error 'No clean git workspace'
        return false
      end

      return _bit_clipboard_lib_git_pull
    end

    true
  end
  # rubocop:enable Metrics/MethodLength

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

    _rakefile, path = Rake.application.find_rakefile_location
    bitmap = "#{path}/.bitmap"

    _bit_clipboard_lib_git_add bitmap
    _bit_clipboard_lib_git_commit bitmap
    _bit_clipboard_lib_git_push
  end

  # git add .bitmap
  def _bit_clipboard_lib_git_add(bitmap)
    log.debug "Adding \"#{bitmap}\" to git"

    cmd_bit_clipboard_git_add = format(
      config.active['cmd_bit_clipboard_git_add'],
      file: bitmap
    )
    run cmd_bit_clipboard_git_add
  end

  # git commit -m "Update .bitmap"
  def _bit_clipboard_lib_git_commit(bitmap)
    message = 'Update .bitmap'

    log.debug "Committing \"#{bitmap}\" to git"

    cmd_bit_clipboard_git_commit = format(
      config.active['cmd_bit_clipboard_git_commit'],
      message: message
    )

    run cmd_bit_clipboard_git_commit
  end

  # git push origin master
  def _bit_clipboard_lib_git_push
    log.debug 'Pushing master branch to origin'

    cmd_bit_clipboard_git_push =
      config.active['cmd_bit_clipboard_git_push']

    run cmd_bit_clipboard_git_push
  end

  # git pull
  def _bit_clipboard_lib_git_pull
    log.debug 'Updating git workspace'
    cmd_bit_clipboard_git_pull =
      config.active['cmd_bit_clipboard_git_pull']

    result_git_pull = try cmd_bit_clipboard_git_pull

    return true unless result_git_pull

    log.error 'Unable to update git workspace'
    false
  end

  # Genereate .gitignore if bitignore is present
  def _bit_clipboard_lib_handle_bitignore
    log.debug 'Handling bitgnore files'

    # find all bitgnore files
    Dir.glob('./**/bitignore').each do |file|
      # get directory of bitignore file
      dir = File.dirname file

      # build gitignore filepath
      gitignore_file = "#{dir}/.gitignore"

      unless File.exist? gitignore_file
        log.debug "Creating \".gitignore\" in \"#{dir}\""
        File.open(gitignore_file, 'w') { |gitignore| gitignore.write('*') }
      end
    end
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
