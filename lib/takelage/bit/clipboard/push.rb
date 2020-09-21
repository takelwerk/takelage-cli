# frozen_string_literal: true

# takelage bit clipboard push
module BitClipboardPush
  # Backend method for bit push.
  def bit_clipboard_push
    log.debug 'Running bit push'

    return false unless configured? %w[project_root_dir]

    return false unless _bit_clipboard_lib_prepare_workspace

    _bit_clipboard_push_tag_all
    _bit_clipboard_push_export_all
    _bit_clipbpard_lib_remove_bit_artifacts
    _bit_clipboard_lib_sync_workspace

    log.info 'Pushed bit components'
    true
  end

  private

  # bit tag all components.
  def _bit_clipboard_push_tag_all
    cmd_bit_tag_all =
      config.active['cmd_bit_clipboard_push_bit_tag_all']

    run cmd_bit_tag_all
  end

  # bit export components.
  def _bit_clipboard_push_export_all
    cmd_bit_export_all =
      config.active['cmd_bit_clipboard_push_bit_export_all']

    run cmd_bit_export_all
  end
end
