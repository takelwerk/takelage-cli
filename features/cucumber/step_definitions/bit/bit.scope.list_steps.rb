# frozen_string_literal: true

Given 'the list of remote scopes is up-to-date' do
  cmd_bit_ssh = @config['bit_ssh']
  root = @config['bit_root']
  cmd_bit_scope_list = format(
    @config['cmd_bit_scope_list_find_scopes'],
    root: root
  )
  cmd_bit_remote_scopes = "HOME=#{aruba.config.home_directory} && " \
    "#{cmd_bit_ssh} '#{cmd_bit_scope_list}'"
  @remote_scopes = `#{cmd_bit_remote_scopes}`
  @remote_scopes.gsub!(%r{#{root}/*}, '')
  @remote_scopes.gsub!(%r{/scope.json}, '')
end

Then 'the output is equal to the list of remote scopes' do
  expect(last_command_started.output.strip).to eq @remote_scopes.strip
end
