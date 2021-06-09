# frozen_string_literal: true

module Takelage
  # takelage init
  class Init < SubCommandBase
    desc 'packer [COMMAND]', 'Init packer project'
    subcommand 'packer', InitPacker
  end
end
