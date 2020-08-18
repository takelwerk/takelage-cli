# frozen_string_literal: true

module Takelage
  # takelage bit requiere
  class BitRequire < SubCommandBase
    include LoggingModule
    include ConfigModule
    include SystemModule
    include BitClipboardLib
    include BitClipboardPaste
    include BitRequireExport
    include BitRequireImport

    #
    # bit require export
    #
    desc 'export', 'Create requirements file with bit components.'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Create requirements file with bit components
    LONGDESC
    # Create requirements file with bit components.
    def export
      exit bit_require_export
    end
    
    #
    # bit require import
    #
    desc 'import', 'Import bit components from a requirements file.'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Import bit components from a requirements file
    LONGDESC
    # Import bit components from a requirements file.
    def import
      exit bit_require_import
    end
  end
end
