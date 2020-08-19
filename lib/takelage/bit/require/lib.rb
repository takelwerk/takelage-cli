# frozen_string_literal: true

# takelage bit require lib
module BitRequireLib
  private

  # Check if a bit requirements file exists
  def _bit_require_lib_check_require_file
    return true if File.exist? @bit_require_file

    log.error "No #{@bit_require_file} file found"
    false
  end
end
