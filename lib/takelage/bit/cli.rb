require 'pathname'

module Takelage

  # takelage bit
  class Bit < SubCommandBase

    include LoggingModule
    include SystemModule
    include ConfigModule

    desc 'clipboard [COMMAND]', 'Manage bit clipboard'
    subcommand 'clipboard', BitClipboard

    desc 'scope [COMMAND]', 'Manage bit scopes'
    subcommand 'scope', BitScope
  end
end
