# frozen_string_literal: true

# takelage bit scope list
module BitScopeList
  # Backend method for bit scope list.
  # @return [String] list of bit scopes
  def bit_scope_list
    log.debug 'Listing bit remote scopes'

    return false unless configured? %w[bit_ssh bit_remote]

    # get ssh command from active config
    cmd_bit_ssh =
      config.active['bit_ssh']

    root = config.active['bit_root']

    cmd_bit_scope_list = _bit_scope_list_cmd root

    # run ssh command with scope list command
    scope_list = run "#{cmd_bit_ssh} '#{cmd_bit_scope_list}'"

    # remove bit remote root directory from results
    scope_list.gsub!(%r{#{root}/*}, '')

    # remove /scope.json from results
    scope_list.gsub!(%r{/scope.json}, '')

    scope_list
  end

  private

  # Prepare bit scope list command.
  def _bit_scope_list_cmd(root)
    format(
      config.active['cmd_bit_scope_list_find_scopes'],
      root: root
    )
  end
end
