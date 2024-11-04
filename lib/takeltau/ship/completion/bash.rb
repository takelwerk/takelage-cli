# frozen_string_literal: true

# tau ship completion bash
module ShipCompletionBash
  # Print bash completion code
  def ship_completion_bash
    tau_completion = Takeltau::CLI.new.bash_fylla
    completion = _ship_completion_bash_remove_lines tau_completion
    completion = _ship_completion_bash_remove_functions completion
    completion << 'complete -F _ship ship'
    completion
  end

  private

  # Remove bash completion lines
  def _ship_completion_bash_remove_lines(tau_completion)
    completion =
      tau_completion
      .strip.split("\n")
    completion.pop
    completion.join("\n")
  end

  # Remove bash completion functions
  def _ship_completion_bash_remove_functions(completion)
    functions =
      completion
      .split(/_tau[^_]*/)
      .grep(/_ship/)
      .grep_v(/_ship\n/)
      .grep_v(/"--help"/)
      .grep_v(/"-h"/)
    functions.join
  end
end
