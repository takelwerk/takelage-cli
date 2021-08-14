# frozen_string_literal: true

module Takeltau
  # semantic version number
  VERSION = (File.read "#{File.dirname(__FILE__)}/../version").chomp

  # takeltau self
  class Self < SubCommandBase
    include LoggingModule
    include SelfList

    desc 'config [COMMAND]', 'Manage takelage configuration'
    subcommand 'config', SelfConfig

    #
    # self list
    #
    desc 'list', 'List all commands'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    List all commands
    LONGDESC
    # List all commands.
    def list
      list = self_list
      exit false if list == false
      say list
      true
    end

    #
    # self version
    #
    desc 'version', 'Print takelage semantic version number'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print takelage semantic version number
    LONGDESC
    # Print takelage semantic version number.
    def version
      say VERSION
      true
    end
  end
end
