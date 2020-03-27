require 'pathname'

module Takelage

  # takelage bit
  class Bit < SubCommandBase

    desc 'check [COMMAND]', 'Check bit state'
    subcommand 'check', BitCheck

    desc 'clipboard [COMMAND]', 'Manage bit clipboard'
    subcommand 'clipboard', BitClipboard

    desc 'scope [COMMAND]', 'Manage bit scopes'
    subcommand 'scope', BitScope
  end
end
