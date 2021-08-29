# frozen_string_literal: true

# takeltau bit scope ssh
module BitScopeSSH
  # Backend method for bit scope ssh.
  def bit_scope_ssh
    log.info 'Logging in to bit remote server'

    return false unless configured? %w[bit_ssh]

    run_and_exit config.active['bit_ssh']
  end
end
