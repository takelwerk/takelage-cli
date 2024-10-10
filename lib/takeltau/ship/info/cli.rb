# frozen_string_literal: true

module Takeltau
  # tau ship info
  class ShipInfo < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include ShipContainerLib
    include ShipInfoLib

    #
    # ship info json
    #
    desc 'json', 'Print json takelship info'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
      Print json takelship info
    LONGDESC
    # Print json takelship info.
    def json
      say _ship_info_lib_get_takelshipinfo.to_json
    end

    #
    # ship info yaml
    #
    desc 'yaml', 'Print yaml takelship info'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
      Print yaml takelship info
    LONGDESC
    # Print yaml takelship info.
    def yaml
      say _ship_info_lib_get_takelshipinfo.to_yaml
    end
  end
end
