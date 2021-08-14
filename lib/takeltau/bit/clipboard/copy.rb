# frozen_string_literal: true

# takeltau bit clipboard copy
module BitClipboardCopy
  # Backend method for bit copy.
  def bit_clipboard_copy(dir, scope)
    # remove trailing slash
    dir = dir.chomp('/')

    log.debug "Running bit copy \"#{dir}\" to \"#{scope}\""

    return false unless configured? %w[project_root_dir]

    return false unless _bit_clipboard_lib_prepare_workspace

    unless File.directory? dir
      log.error "The directory \"#{dir}\" does not exist"
      return false
    end

    _bit_clipboard_copy_dir dir, scope
  end

  private

  # rubocop:disable Metrics/MethodLength
  def _bit_clipboard_copy_dir(dir, scope)
    log.debug "Adding the directory \"#{dir}\" as a tagged bit component"

    return false unless _bit_clipboard_copy_dir_scope_exists? scope

    return false if _bit_clipboard_copy_readme_bit_exists_in_subdir? dir

    id = _bit_clipboard_lib_id(dir)

    _bit_clipboard_copy_touch_readme_bit dir
    _bit_clipboard_copy_add_dir id, dir
    _bit_clipboard_copy_tag_dir id
    _bit_clipboard_copy_export_to_scope scope
    _bit_clipbpard_lib_remove_bit_artifacts
    _bit_clipboard_lib_sync_workspace

    log.info "Copied directory \"#{dir}\" as bit component \"#{id}\" " \
             "to bit remote scope \"#{scope}\""
  end
  # rubocop:enable Metrics/MethodLength

  # Touch README.bit if necessary.
  def _bit_clipboard_copy_touch_readme_bit(dir)
    readme_bit = "#{dir}/README.bit"
    return if File.file? readme_bit

    log.info "Creating \"README.bit\" in \"#{dir}\""
    File.open(readme_bit, 'w') {}
  end

  # Check if a README.bit file exists in a subdirectory.
  def _bit_clipboard_copy_readme_bit_exists_in_subdir?(dir)
    Dir.glob("#{dir}/**/README.bit").each do |file|
      unless file == "#{dir}/README.bit"
        log.error 'Nested README.bit file detected'
        return true
      end
    end

    false
  end

  # Check if bit scope exists.
  def _bit_clipboard_copy_dir_scope_exists?(scope)
    bit_dev = config.active['bit_dev_user']

    # check if scope is a candidate for a bit.dev remote scope
    if scope.start_with? "#{bit_dev}."
      return false unless _bit_clipboard_bit_dev_scope_exists scope
    else
      return false unless _bit_clipboard_custom_scope_exists scope
    end

    true
  end

  # Check if bit.dev remote scope exists.
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

  # Check if bit remote scope is added to local workspace.
  def _bit_clipboard_custom_scope_exists(scope)
    cmd_bit_list_remotes =
      config.active['cmd_bit_clipboard_copy_bit_list_remotes']

    stdout_str = run cmd_bit_list_remotes

    return true if /.*\s+#{scope}\s+.*/m.match? stdout_str

    log.error "No bit remote scope \"#{scope}\" " \
                    'found in local bit workspace'
    false
  end

  # bit tag dir.
  def _bit_clipboard_copy_add_dir(id, dir)
    cmd_bit_add_dir = format(
      config.active['cmd_bit_clipboard_copy_bit_add_dir'],
      id: id,
      dir: dir
    )

    run cmd_bit_add_dir
  end

  # bit tag dir.
  def _bit_clipboard_copy_tag_dir(id)
    cmd_bit_tag_id = format(
      config.active['cmd_bit_clipboard_copy_bit_tag_id'],
      id: id
    )

    run cmd_bit_tag_id
  end

  # bit export component to bit remote scope.
  def _bit_clipboard_copy_export_to_scope(scope)
    cmd_bit_export_to_scope = format(
      config.active['cmd_bit_clipboard_copy_bit_export_to_scope'],
      scope: scope
    )

    run cmd_bit_export_to_scope
  end
end
