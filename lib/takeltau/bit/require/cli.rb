# frozen_string_literal: true

module Takeltau
  # takeltau bit requiere
  class BitRequire < SubCommandBase
    include LoggingModule
    include ConfigModule
    include SystemModule
    include GitCheckClean
    include GitCheckBit
    include GitCheckWorkspace
    include BitCheckWorkspace
    include BitScopeList
    include BitScopeAdd
    include BitClipboardLib
    include BitClipboardCopy
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
      bit_require_yml = bit_require_export
      exit false if bit_require_yml == false
      say bit_require_yml
      true
    end

    #
    # bit require import
    #
    desc 'import', 'Import bit components from requirements file.'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Import bit components from requirements file
    LONGDESC
    # Import bit components from requirements file.
    def import
      exit bit_require_import
    end
  end
end
