# frozen_string_literal: true

Given 'the takelage default configuration' do
  @default_configuration = YAML.load File.read 'lib/takelage/default.yml'
end

Then  'the output should contain exactly the default config' do
  expect(YAML.load last_command_started.output).to eq @default_configuration
end
