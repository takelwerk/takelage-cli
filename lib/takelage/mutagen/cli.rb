# frozen_string_literal: true

module Takelage
  # takelage git
  class Mutagen < SubCommandBase
    desc 'socket [COMMAND]', 'Manage mutagen socket'
    subcommand 'socket', MutagenSocket
  end
end
