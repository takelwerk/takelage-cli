module Takelage

  # takelage completion
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
      say Takelage::CLI.new.bash_fylla
    end
  end
end
