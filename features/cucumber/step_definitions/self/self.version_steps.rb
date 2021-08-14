# frozen_string_literal: true

Given 'I read the takeltau version from the version file' do
  version_file = "#{File.dirname(__FILE__)}/../../../../lib/takeltau/version"
  @takelage_version_number = (File.read version_file).chomp
end

Then 'the output should contain the takeltau version' do
  expect(last_command_started.output.chomp).to eq @takelage_version_number
end
