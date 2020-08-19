# frozen_string_literal: true

module Takelage
  # takelage bit requiere
  class BitRequire < SubCommandBase
    include LoggingModule
    include ConfigModule
    include SystemModule
    include GitCheckClean
    include GitCheckMaster
    include GitCheckWorkspace
    include BitCheckWorkspace
    include BitScopeAdd
    include BitClipboardLib
    include BitClipboardPaste
    include BitRequireLib
    include BitRequireExport
    include BitRequireImport

    # Initialize bit require
    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      @bit_require_file = config.active['bit_require_file']
    end

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
