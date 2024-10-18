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
  # rubocop:disable Style/BlockDelimiters
  def _ship_completion_bash_remove_lines(tau_completion)
    completion =
      tau_completion
      .strip.split("\n")
    completion.pop
    completion.join("\n")
  end
  # rubocop:enable Style/BlockDelimiters

  # Remove bash completion functions
  def _ship_completion_bash_remove_functions(completion)
    functions =
      completion
      .split(/_tau[^_]*/)
      .select { |f| f =~ /_ship/ }
      .reject { |f| f =~ /_ship\n/ }
      .reject { |f| f.include? 'help ()' }
    functions.join('')
  end
end
