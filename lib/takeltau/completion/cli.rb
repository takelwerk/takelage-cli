# frozen_string_literal: true

module Takeltau
  # tau completion
  class Completion < SubCommandBase
    include LoggingModule

    desc 'bash', 'Print bash completion code'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print bash completion code
    This command will print bash code which can be parsed to enable auto-completion for the takelage cli.
    Add this to your bash startup files:

    source <(tau completion bash)
    LONGDESC
    # Print bash completion code.
    def bash
      completion_bash = Takeltau::CLI.new.bash_fylla
      exit false if completion_bash == false
      say completion_bash.strip.split("\n").grep_v(/"--help"/).grep_v(/"-h"/).join("\n")
      true
    end
  end
end
