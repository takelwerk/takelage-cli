Given 'the list of remote scopes is up-to-date' do
  cmd_bit_ssh = @config['bit_ssh']
  root = @config['bit_scope_root']
  cmd_bit_scope_list = @config['bit_scope_list'] % {root: root}
  @remote_scopes = `#{cmd_bit_ssh} '#{cmd_bit_scope_list}'`
  @remote_scopes.gsub!(/#{root}\/*/, '')
  @remote_scopes.gsub!(/\/scope.json/, '')
end

Then 'the output is equal to the list of remote scopes' do
  expect(last_command_started.output.strip).to eq @remote_scopes.strip
end
