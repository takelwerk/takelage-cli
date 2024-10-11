# frozen_string_literal: true

# tau ship completion bash
module ShipCompletionBash
  # Print bash completion code
  def ship_completion_bash
    tau_completion = Takeltau::CLI.new.bash_fylla
    completion = tau_completion.strip.split("\n").reject{ |line |
      line.include? 'options+=("--help")' or
        line.include? 'options+=("-h")'
    }
    completion.pop
    completion = completion.join("\n")
    functions = completion.
      split(/_tau[^_]*/)
      .select { |f | f =~ /_ship/ }
      .reject { | f | f =~ /_ship\n/ }
      .reject { |f | f.include? 'help ()' }
    completion = functions.join('')
    completion << "complete -F _ship ship"
    completion
  end
end
