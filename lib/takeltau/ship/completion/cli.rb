# frozen_string_literal: true

module Takeltau
  # tau completion
  class ShipCompletion < SubCommandBase
    include LoggingModule
    include ShipCompletionBash

    desc 'bash', 'Print bash completion code'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print bash completion code
    This command will print bash code which can be parsed to enable auto-completion for the takelship cli.
    Add this to your bash startup files:

    source <(ship completion bash)
    LONGDESC
    def bash
      completion_bash = ship_completion_bash
      exit false if completion_bash == false
      say completion_bash
      true
    end
  end
end
