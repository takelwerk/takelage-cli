# frozen_string_literal: true

module Takeltau
  # takeltau bit
  class Bit < SubCommandBase
    desc 'check [COMMAND]', 'Check bit state'
    subcommand 'check', BitCheck

    desc 'clipboard [COMMAND]', 'Manage bit clipboard'
    subcommand 'clipboard', BitClipboard

    desc 'require [COMMAND]', 'Manage bit requirements'
    subcommand 'require', BitRequire

    desc 'scope [COMMAND]', 'Manage bit scopes'
    subcommand 'scope', BitScope
  end
end
