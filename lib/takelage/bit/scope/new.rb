# frozen_string_literal: true

# takelage bit scope new
module BitScopeNew
  # Backend method for bit scope new.
  # @return [Int] status of new command
  def bit_scope_new(scope)
    log.debug "Creating new bit remote scope \"#{scope}\""

    return false unless configured? %w[bit_ssh bit_remote]

    return false if _bit_scope_new_scope_exists? scope

    cmd_bit_ssh = config.active['bit_ssh']

    cmd_bit_scope_new = _bit_scope_new_cmd scope

    run "#{cmd_bit_ssh} '#{cmd_bit_scope_new}'"

    log.info "Created new bit remote scope \"#{scope}\""
  end

  private

  # Check if bit scope already exists.
  def _bit_scope_new_scope_exists?(scope)
    scope_list = bit_scope_list
    return false unless scope_list.include? scope

    log.error "The remote bit scope \"#{scope}\" already exists"
    false
  end

  # Prepare bit scope new command.
  def _bit_scope_new_cmd(scope)
    root = config.active['bit_root']

    format(
      config.active['cmd_bit_scope_new_bit_init'],
      scope: scope,
      root: root
    )
  end
end
