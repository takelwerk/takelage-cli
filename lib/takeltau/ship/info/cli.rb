# frozen_string_literal: true

module Takeltau
  # tau ship info
  class ShipInfo < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon
    include ShipContainerLib
    include ShipInfoLib

    desc 'takelconfig', 'Print takelage config'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print takelage config.
    The configuration values can be overwritten by a
    1. ~/.takelage.yml in your home directory
    2. takelage.yml next to a takelship directory
    3. environment variables like TAKELAGE_TAU_CONFIG_SHIP_NAME
    Alias for tau self config.
    LONGDESC
    # ship takelconfig: {Takeltau::SelfConfig#active}
    def takelconfig
      Takeltau::SelfConfig.new.active
    end

    #
    # ship info takelship
    #
    desc 'takelship', 'Print takelship info'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print takelship info.
    This info is read from a takelship.yml file in a takelship directory.
    If no such file exists the info is gathered from a takelship.
    LONGDESC
    def takelship
      say _ship_info_lib_get_takelshipinfo.to_yaml
    end

    #
    # ship info version
    #
    desc 'version', 'Print ship version'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print ship semantic version number.
    LONGDESC
    def version
      say VERSION
      true
    end

  end
end
