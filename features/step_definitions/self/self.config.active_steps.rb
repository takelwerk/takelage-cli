# frozen_string_literal: true

Given 'I get the active takelage config' do
  cmd_takelage_config_active = "HOME=#{aruba.config.home_directory} " \
    'tau-cli config'
  @config = YAML.safe_load `#{cmd_takelage_config_active}`
end

Then 'the output should contain the bit_remote default' do
  @active_configuration = YAML.safe_load last_command_started.output
  bit_remote_active = @active_configuration['bit_remote']
  bit_remote_default = @default_configuration['bit_remote']
  expect(bit_remote_active).to eq bit_remote_default
end
