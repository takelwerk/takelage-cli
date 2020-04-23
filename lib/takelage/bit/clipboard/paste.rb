# frozen_string_literal: true

# takelage bit clipboard paste
module BitClipboardPaste
  # Backend method for bit paste.
  def bit_clipboard_paste(cid, dir)
    log.debug "Running bit paste \"#{cid}\" to \"#{dir}\""

    return false unless _bit_clipboard_lib_prepare_workspace

    return false unless _bit_clipboard_paste_cid_exists? cid

    _bit_clipboard_paste_import_cid cid, dir
    _bit_clipboard_lib_handle_bitignore
    _bit_clipbpard_lib_remove_bit_artifacts
    _bit_clipboard_lib_sync_workspace

    log.info "Pasted bit component \"#{cid}\" to directory \"#{dir}\""
    true
  end

  private

  # paste bit component into directory
  def _bit_clipboard_paste_import_cid(cid, dir)
    cmd_bit_import_cid = format(
      config.active['cmd_bit_clipboard_paste_bit_import_cid'],
      cid: cid,
      dir: dir
    )

    run cmd_bit_import_cid
  end

  def _bit_clipboard_paste_cid_exists?(cid)
    scope = cid.scan(%r{([^/]*).*}).first.first

    log.debug "Checking if scope \"#{scope}\" " \
              "contains component id \"#{cid}\""

    bit_list_scope = _bit_clipboard_paste_cid_exists_list_scope scope

    return true if bit_list_scope.include? '"id": "' + cid + '",'

    log.error "No remote component \"#{cid}\""
    false
  end

  # get components in remote scope
  def _bit_clipboard_paste_cid_exists_list_scope(scope)
    cmd_bit_list_scope = format(
      config.active['cmd_bit_clipboard_paste_bit_list_scope'],
      scope: scope
    )

    run cmd_bit_list_scope
  end
end
