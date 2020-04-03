# takelage bit clipboard module
module BitClipboardModule

  # Backend method for bit copy.
  def bit_clipboard_copy(dir, scope)
    log.debug "Running bit copy \"#{dir}\" to \"#{scope}\""

    unless bit_check_workspace
      log.error 'No bit workspace'
      return false
    end

    if git_check_workspace
      unless git_check_master
        log.error 'Not on git master branch'
        return false
      end
    end

    if File.directory? dir

      # remove trailing slash
      dir = dir.chomp('/')

      log.debug "Adding the directory \"#{dir}\" as a tagged bit component"

      bit_dev = config.active['bit_dev']

      # check if scope is a candidate for a bit.dev remote scope
      if scope.start_with? bit_dev + '.'

        # check if bit.dev remote scope exists
        cmd_bit_list_scope = config.active['bit_list_scope'] % {scope: scope}
        status = try cmd_bit_list_scope

        unless status.exitstatus.zero?
          log.error "No bit.dev remote scope \"#{scope}\" found"
          return false
        end

      else

        # check if bit remote scope is added to local workspace
        cmd_bit_list_remotes = config.active['bit_list_remotes']
        stdout_str = run cmd_bit_list_remotes

        unless /.*\s+#{scope}\s+.*/m.match? stdout_str
          log.error "No bit remote scope \"#{scope}\" found in local bit workspace"
          return false
        end
      end

      # check if a README.bit file exists in a subdirectory
      Dir.glob("#{dir}/**/README.bit").each do |file|
        unless file == "#{dir}/README.bit"
          log.error "Nested README.bit file detected"
          return false
        end
      end

      # touch README.bit if necessary
      readme_bit = "#{dir}/README.bit"
      unless File.file? readme_bit
        log.info "Creating \"README.bit\" in \"#{dir}\""
        File.open(readme_bit, 'w') {}
      end

      # generate component id from directory name
      id = _id(dir)

      # get bit add dir command from active config
      cmd_bit_add_dir = config.active['bit_add_dir'] % {id: id, dir: dir}
      run cmd_bit_add_dir

      # get bit tag dir command from active config
      cmd_bit_tag_id = config.active['bit_tag_id'] % {id: id}
      run cmd_bit_tag_id
    else
      log.error "The directory \"#{dir}\" does not exist"
      return false
    end

    # export component to bit remote scope
    cmd_bit_export_to_scope = config.active['bit_export_to_scope'] % {scope: scope}
    run cmd_bit_export_to_scope

    _remove_bit_artifacts

    log.info "Copied directory \"#{dir}\" " +
                 "as bit component \"#{id}\" " +
                 "to bit remote scope \"#{scope}\""
    true
  end

  # Backend method for bit paste.
  def bit_clipboard_paste(cid, dir)
    log.debug "Running bit paste \"#{cid}\" to \"#{dir}\""

    unless bit_check_workspace
      log.error 'No bit workspace'
      return false
    end

    if git_check_workspace
      unless git_check_master
        log.error 'Not on git master branch'
        return false
      end
    end

    scope = cid.scan(/([^\/]*).*/).first.first

    log.debug "Checking if scope \"#{scope}\" " +
                  "has contains component id \"#{cid}\""

    # get components in remote scope
    cmd_bit_list_scope = config.active['bit_list_scope'] % {scope: scope}
    bit_list_scope = run cmd_bit_list_scope

    unless bit_list_scope.include? '"id": "' + cid + '",'
      log.error "No remote scope \"#{scope}\""
      return false
    end

    # paste bit component into directory
    cmd_bit_import_cid = config.active['bit_import_cid'] % {cid: cid, dir: dir}
    run cmd_bit_import_cid

    _handle_bitignore
    _remove_bit_artifacts

    log.info "Pasted bit component \"#{cid}\" " +
                 "to directory \"#{dir}\""
    true
  end

  # Backend method for bit pull.
  def bit_clipboard_pull
    log.debug "Running bit pull"

    unless bit_check_workspace
      log.error 'No bit workspace'
      return false
    end

    if git_check_workspace
      unless git_check_master
        log.error 'Not on git master branch'
        return false
      end
    end

    # import components into workspace
    cmd_bit_import_all = config.active['bit_import_all']
    run cmd_bit_import_all

    # checkout components and merge them
    cmd_bit_checkout_all = config.active['bit_checkout_all']
    run cmd_bit_checkout_all

    _handle_bitignore
    _remove_bit_artifacts

    log.info "Pulled bit components"
    true
  end

  # Backend method for bit push
  def bit_clipboard_push
    log.debug "Running bit push"

    unless bit_check_workspace
      log.error 'No bit workspace'
      return false
    end

    if git_check_workspace
      unless git_check_master
        log.error 'Not on git master branch'
        return false
      end
    end

    # tag all components
    cmd_bit_tag_all = config.active['bit_tag_all']
    run cmd_bit_tag_all

    # export components
    cmd_bit_export_all = config.active['bit_export_all']
    run cmd_bit_export_all

    _remove_bit_artifacts

    log.info "Pushed bit components"
    true
  end

  # Genereate .gitignore if bitignore is present
  def _handle_bitignore
    log.debug "Handling bitgnore files"

    # find all bitgnore files
    Dir.glob("./**/bitignore").each do |file|

      log.debug file

      # get directory of bitignore file
      dir = File.dirname file

      # build gitignore filepath
      gitignore = "#{dir}/.gitignore"

      log.debug gitignore

      unless File.exist? gitignore
        log.debug "Creating \".gitignore\" in \"#{dir}\""
        File.open(gitignore, 'w') { |gitignore| gitignore.write('*') }
      end
    end
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
      id += (allowed_chars.include? char) ? char : '_'
    end

    log.debug "Generated bit id \"#{id}\" from \"#{name}\""
    id
  end

  # Remove bit artifacts.
  def _remove_bit_artifacts
    log.debug "Removing bit artifacts"

    _remove_node_modules
    _remove_index_bit
    _remove_package_json
  end

  # Remove node_modules directory.
  def _remove_node_modules
    FileUtils.remove_entry_secure('node_modules', force: true)
  end

  # Remove index.bit files recursively.
  def _remove_index_bit
    Dir.glob("./**/index.bit").each do |file|
      FileUtils.remove_entry_secure(file, force: true)
    end
  end

  # Remove package.json file.
  def _remove_package_json
    FileUtils.remove_entry_secure('package.json', force: true)
  end
end
