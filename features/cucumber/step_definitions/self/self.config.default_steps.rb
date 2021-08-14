# frozen_string_literal: true

Given 'the takeltau default configuration' do
  @default_configuration = YAML.safe_load(File.read('lib/takeltau/default.yml'))
  @default_configuration['project_root_dir'] = ''
end

Then 'the output should contain exactly the default config' do
  output_yaml = YAML.safe_load(last_command_started.output)
  expect(output_yaml).to eq @default_configuration
end
