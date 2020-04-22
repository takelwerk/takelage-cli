# frozen_string_literal: true

# takelage bit clipboard module
module BitClipboardModule
  # Backend method for bit copy.
  def bit_clipboard_copy(dir, scope)
    # remove trailing slash
    dir = dir.chomp('/')

    log.debug "Running bit copy \"#{dir}\" to \"#{scope}\""

    return false unless _bit_clipboard_prepare_workspace

    unless File.directory? dir
      log.error "The directory \"#{dir}\" does not exist"
      return false
    end

    _bit_clipboard_copy_dir dir, scope
  end

  # Backend method for bit paste.
  def bit_clipboard_paste(cid, dir)
    log.debug "Running bit paste \"#{cid}\" to \"#{dir}\""

    return false unless _bit_clipboard_prepare_workspace

    return false unless _bit_clipboard_cid_exists? cid

    _bit_clipboard_import_cid cid, dir
    _handle_bitignore
    _bit_clipbpard_remove_bit_artifacts
    _bit_clipboard_sync_workspace

    log.info "Pasted bit component \"#{cid}\" to directory \"#{dir}\""
    true
  end

  # Backend method for bit pull.
  def bit_clipboard_pull
    log.debug 'Running bit pull'

    return false unless _bit_clipboard_prepare_workspace

    _bit_clipboard_import_all
    _bit_clipboard_checkout_all
    _handle_bitignore
    _bit_clipbpard_remove_bit_artifacts
    _bit_clipboard_sync_workspace

    log.info 'Pulled bit components'
    true
  end

  # Backend method for bit push
  def bit_clipboard_push
    log.debug 'Running bit push'

    return false unless _bit_clipboard_prepare_workspace

    _bit_clipboard_tag_all
    _bit_clipboard_export_all
    _bit_clipbpard_remove_bit_artifacts
    _bit_clipboard_sync_workspace

    log.info 'Pushed bit components'
    true
  end

  private

  # rubocop:disable Metrics/MethodLength
  def _bit_clipboard_copy_dir(dir, scope)
    log.debug "Adding the directory \"#{dir}\" as a tagged bit component"

    return false unless _bit_clipboard_copy_dir_scope_exists scope

    puts "$$$$$$$$$$$$"

    return false if _bit_clipboard_readme_bit_exists_in_subdir dir

    puts "***************"

    id = _id(dir)

    _bit_clipboard_touch_readme_bit dir
    _bit_clipboard_add_dir id, dir
    _bit_clipboard_tag_dir id
    _bit_clipboard_export_to_scope scope
    _bit_clipbpard_remove_bit_artifacts
    _bit_clipboard_sync_workspace

    log.info "Copied directory \"#{dir}\" as bit component \"#{id}\" " \
             "to bit remote scope \"#{scope}\""
  end
  # rubocop:enable Metrics/MethodLength

  # Genereate .gitignore if bitignore is present
  def _handle_bitignore
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

  # touch README.bit if necessary
  def _bit_clipboard_touch_readme_bit(dir)
    readme_bit = "#{dir}/README.bit"
    return if File.file? readme_bit

    log.info "Creating \"README.bit\" in \"#{dir}\""
    File.open(readme_bit, 'w') {}
  end

  # check if a README.bit file exists in a subdirectory
  def _bit_clipboard_readme_bit_exists_in_subdir(dir)
    Dir.glob("#{dir}/**/README.bit").each do |file|
      unless file == "#{dir}/README.bit"
        log.error 'Nested README.bit file detected'
        return true
      end
    end

    false
  end

  # Check if bit scope exists
  def _bit_clipboard_copy_dir_scope_exists(scope)
    bit_dev = config.active['bit_dev_user']

    # check if scope is a candidate for a bit.dev remote scope
    if scope.start_with? bit_dev + '.'
      return false unless _bit_clipboard_bit_dev_scope_exists scope
    else
      return false unless _bit_clipboard_custom_scope_exists scope
    end

    true
  end

  # check if bit.dev remote scope exists
  def _bit_clipboard_bit_dev_scope_exists(scope)
    cmd_bit_list_scope = format(
      config.active['cmd_bit_clipboard_copy_bit_list_scope'],
      scope: scope
    )

    status = try cmd_bit_list_scope

    return true if status.exitstatus.zero?

    log.error "No bit.dev remote scope \"#{scope}\" found"
    false
  end

  # check if bit remote scope is added to local workspace
  def _bit_clipboard_custom_scope_exists(scope)
    cmd_bit_list_remotes =
      config.active['cmd_bit_clipboard_copy_bit_list_remotes']

    stdout_str = run cmd_bit_list_remotes

    return true if /.*\s+#{scope}\s+.*/m.match? stdout_str

    log.error "No bit remote scope \"#{scope}\" " \
                    'found in local bit workspace'
    false
  end

  # Generate bit component ID.
  def _id(name)
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

  # Prepare workspace for bit clipboard.
  # rubocop:disable Metrics/MethodLength
  def _bit_clipboard_prepare_workspace
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

      return _bit_clipboard_git_pull
    end

    true
  end
  # rubocop:enable Metrics/MethodLength

  def _bit_clipboard_cid_exists?(cid)
    scope = cid.scan(%r{([^/]*).*}).first.first

    log.debug "Checking if scope \"#{scope}\" " \
                "contains component id \"#{cid}\""

    bit_list_scope = _bit_clipboard_cid_exists_list_scope scope

    return true unless bit_list_scope.include? '"id": "' + cid + '",'

    log.error "No remote component \"#{cid}\""
    false
  end

  # Remove bit artifacts.
  def _bit_clipbpard_remove_bit_artifacts
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

  # bit tag dir
  def _bit_clipboard_add_dir(id, dir)
    cmd_bit_add_dir = format(
      config.active['cmd_bit_clipboard_copy_bit_add_dir'],
      id: id,
      dir: dir
    )

    run cmd_bit_add_dir
  end

  # bit tag dir
  def _bit_clipboard_tag_dir(id)
    cmd_bit_tag_id = format(
      config.active['cmd_bit_clipboard_copy_bit_tag_id'],
      id: id
    )

    run cmd_bit_tag_id
  end

  # bit export component to bit remote scope
  def _bit_clipboard_export_to_scope(scope)
    cmd_bit_export_to_scope = format(
      config.active['cmd_bit_clipboard_copy_bit_export_to_scope'],
      scope: scope
    )

    run cmd_bit_export_to_scope
  end

  # paste bit component into directory
  def _bit_clipboard_import_cid(cid, dir)
    cmd_bit_import_cid = format(
      config.active['cmd_bit_clipboard_paste_bit_import_cid'],
      cid: cid,
      dir: dir
    )

    run cmd_bit_import_cid
  end

  # bit import components into workspace
  def _bit_clipboard_import_all
    cmd_bit_import_all =
      config.active['cmd_bit_clipboard_pull_bit_import_all']

    run cmd_bit_import_all
  end

  # checkout components and merge them
  def _bit_clipboard_checkout_all
    cmd_bit_checkout_all =
      config.active['cmd_bit_clipboard_pull_bit_checkout_all']

    run cmd_bit_checkout_all
  end

  # bit tag all components
  def _bit_clipboard_tag_all
    cmd_bit_tag_all =
      config.active['cmd_bit_clipboard_push_bit_tag_all']

    run cmd_bit_tag_all
  end

  # bit export components
  def _bit_clipboard_export_all
    cmd_bit_export_all =
      config.active['cmd_bit_clipboard_push_bit_export_all']

    run cmd_bit_export_all
  end

  # Sync workspace with upstream.
  def _bit_clipboard_sync_workspace
    log.debug 'Syncing git workspace'

    _rakefile, path = Rake.application.find_rakefile_location
    bitmap = "#{path}/.bitmap"

    _bit_clipboard_git_add bitmap
    _bit_clipboard_git_commit bitmap
    _bit_clipboard_git_push
  end

  # git add .bitmap
  def _bit_clipboard_git_add(bitmap)
    log.debug "Adding \"#{bitmap}\" to git"

    cmd_bit_clipboard_git_add = format(
      config.active['cmd_bit_clipboard_git_add'],
      file: bitmap
    )
    run cmd_bit_clipboard_git_add
  end

  # git commit -m "Update .bitmap"
  def _bit_clipboard_git_commit(bitmap)
    message = 'Update .bitmap'

    log.debug "Committing \"#{bitmap}\" to git"

    cmd_bit_clipboard_git_commit = format(
      config.active['cmd_bit_clipboard_git_commit'],
      message: message
    )

    run cmd_bit_clipboard_git_commit
  end

  # git push origin master
  def _bit_clipboard_git_push
    log.debug 'Pushing master branch to origin'

    cmd_bit_clipboard_git_push =
      config.active['cmd_bit_clipboard_git_push']

    run cmd_bit_clipboard_git_push
  end

  # git pull
  def _bit_clipboard_git_pull
    log.debug 'Updating git workspace'
    cmd_bit_clipboard_git_pull =
      config.active['cmd_bit_clipboard_git_pull']

    result_git_pull = try cmd_bit_clipboard_git_pull

    return true unless result_git_pull

    log.error 'Unable to update git workspace'
    false
  end

  # get components in remote scope
  def _bit_clipboard_cid_exists_list_scope(scope)
    cmd_bit_list_scope = format(
      config.active['cmd_bit_clipboard_paste_bit_list_scope'],
      scope: scope
    )

    run cmd_bit_list_scope
  end
end
