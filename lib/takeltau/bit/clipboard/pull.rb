# frozen_string_literal: true

# takeltau bit clipboard pull
module BitClipboardPull
  # Backend method for bit pull.
  def bit_clipboard_pull
    log.info 'Running bit pull'

    return false unless configured? %w[project_root_dir]

    return false unless _bit_clipboard_lib_prepare_workspace

    _bit_clipboard_pull_import_all
    _bit_clipboard_pull_checkout_all
    _bit_clipbpard_lib_remove_bit_artifacts
    _bit_clipboard_lib_sync_workspace
    _bit_clipboard_lib_bit_status
  end

  private

  # bit import components into workspace.
  def _bit_clipboard_pull_import_all
    cmd_bit_import_all =
      config.active['cmd_bit_clipboard_pull_bit_import_all']

    run cmd_bit_import_all
  end

  # Checkout components and merge them.
  def _bit_clipboard_pull_checkout_all
    cmd_bit_checkout_all =
      config.active['cmd_bit_clipboard_pull_bit_checkout_all']

    run cmd_bit_checkout_all
  end
end
