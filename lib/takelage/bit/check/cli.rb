module Takelage

  # takelage bit check
  class BitCheck < SubCommandBase

    include LoggingModule
    include SystemModule
    include ConfigModule
    include BitCheckModule

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
