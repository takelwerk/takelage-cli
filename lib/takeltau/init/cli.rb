# frozen_string_literal: true

module Takeltau
  # takeltau init
  class Init < SubCommandBase
    desc 'packer [COMMAND]', 'Init packer project'
    subcommand 'packer', InitPacker

    desc 'takelage [COMMAND]', 'Init takelage project'
    subcommand 'takelage', InitTakelage
  end
end
