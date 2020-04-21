# frozen_string_literal: true

module Takelage
  # takelage info
  class Info < SubCommandBase
    desc 'project [COMMAND]', 'Get project info'
    subcommand 'project', InfoProject
  end
end
