Given 'I get the active takelage config' do
  cmd_takelage_config_active = "HOME=#{aruba.config.home_directory} tau-cli config"
  @config = YAML.load `#{cmd_takelage_config_active}`
end

Then 'the output should contain the bit_remote default' do
  @active_configuration = YAML.load last_command_started.output
  expect(@active_configuration['bit-remote']).to eq @default_configuration['bit-remote']
end
