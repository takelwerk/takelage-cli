# frozen_string_literal: true

module Takelage
  # takelage git
  class Mutagen < SubCommandBase
    desc 'check [COMMAND]', 'Check mutagen'
    subcommand 'check', MutagenCheck

    desc 'socket [COMMAND]', 'Manage mutagen socket'
    subcommand 'socket', MutagenSocket
  end
end
