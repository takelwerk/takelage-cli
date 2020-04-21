# frozen_string_literal: true

Given 'I infinitize {string} in {string}' do |file, container|
  cmd_infinitize_file = 'docker cp ' \
      'features/fixtures/takelage-mock/infinite.sh ' \
      "#{container}:#{file}"
  cmd_change_permissions = 'docker exec ' \
      '--interactive ' \
      "#{container} " \
      "chmod 755 #{file}"
  system cmd_infinitize_file
  system cmd_change_permissions
end

Given 'I daemonize {string} in {string}' do |file, container|
  cmd_daemonize_file = 'docker exec ' \
      '--interactive ' \
      "#{container} " \
      "#{file} & "\
      '>/dev/null 2>&1'
  system cmd_daemonize_file
end
