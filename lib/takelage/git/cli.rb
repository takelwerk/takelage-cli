module Takelage

  # takelage git
  class Git < SubCommandBase

    desc 'check [COMMAND]', 'Check git state'
    subcommand 'check', GitCheck

  end
end
