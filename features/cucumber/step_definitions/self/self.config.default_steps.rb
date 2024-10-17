# frozen_string_literal: true

Given 'the takeltau default configuration' do
  @default_configuration = YAML.safe_load(File.read('lib/takeltau/default.yml'))
end

Then 'the output should contain exactly the default config' do
  output_yaml = YAML.safe_load(last_command_started.output)
  output_yaml.delete('project_root_dir')
  expect(output_yaml).to eq @default_configuration
end
