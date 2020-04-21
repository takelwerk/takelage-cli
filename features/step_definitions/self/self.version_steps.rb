# frozen_string_literal: true

Given 'I read the takelage version from the version file' do
  @takelage_version_number = (File.read "#{File.dirname(__FILE__)}/../../../lib/takelage/version").chomp
end

Then 'the output should contain the takelage version' do
  expect(last_command_started.output.chomp).to eq @takelage_version_number
end
