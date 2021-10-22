# frozen_string_literal: true

module Takeltau
  # semantic version number
  VERSION = (File.read "#{File.dirname(__FILE__)}/../version").chomp

  # tau self
  class Self < SubCommandBase
    include LoggingModule
    include SelfCommands

    desc 'config [COMMAND]', 'Manage takeltau configuration'
    subcommand 'config', SelfConfig

    #
    # self commands
    #
    desc 'commands', 'List all commands'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    List all commands
    LONGDESC
    # List all commands.
    def commands
      commands = self_commands
      exit false if commands == false
      say commands
      true
    end

    #
    # self version
    #
    desc 'version', 'Print takeltau semantic version number'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print takeltau semantic version number
    LONGDESC
    # Print takeltau semantic version number.
    def version
      say VERSION
      true
    end
  end
end
