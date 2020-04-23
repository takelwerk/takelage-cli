# frozen_string_literal: true

# takelage bit scope inbit
module BitScopeInbit
  # Backend method for bit scope inbit.
  def bit_scope_inbit
    log.debug 'Logging in to bit remote server'

    return false unless configured? %w[bit_ssh]

    run_and_exit config.active['bit_ssh']
  end
end
