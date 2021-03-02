# frozen_string_literal: true

module Takelage
  # takelage info status
  class InfoStatus < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include InfoStatusGPG

    #
    # info status gpg
    #
    desc 'gpg', 'Print gpg status info'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print gpg status info
    LONGDESC
    # Print gpg status info.
    def gpg
      exit info_status_gpg
    end
  end
end
