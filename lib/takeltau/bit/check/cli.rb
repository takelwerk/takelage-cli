# frozen_string_literal: true

module Takeltau
  # takeltau bit check
  class BitCheck < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include BitCheckWorkspace

    #
    # bit check workspace
    #
    desc 'workspace', 'Check if a bit workspace exists'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if a bit workspace exists
    LONGDESC
    # Check if a bit workspace exists.
    def workspace
      exit bit_check_workspace
    end
  end
end
