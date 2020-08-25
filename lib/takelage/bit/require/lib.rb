# frozen_string_literal: true

# takelage bit require lib
module BitRequireLib
  private

  # Get bit components.
  def _bit_require_lib_get_components
    cmd_bit_list = config.active['cmd_bit_require_lib_bit_list']
    bit_list = run cmd_bit_list
    JSON.parse bit_list
  end

  # Get bit components ids.
  def _bit_require_lib_get_components_ids
    cmd_bit_list_ids = config.active['cmd_bit_require_lib_bit_list_ids']
    run cmd_bit_list_ids
  end
end
