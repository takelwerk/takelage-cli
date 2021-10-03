# frozen_string_literal: true

module Takeltau
  # tau git
  class Git < SubCommandBase
    desc 'check [COMMAND]', 'Check git state'
    subcommand 'check', GitCheck
  end
end
