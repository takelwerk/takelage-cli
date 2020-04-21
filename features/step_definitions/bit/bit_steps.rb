# frozen_string_literal: true

Given 'I initialize a bit workspace in {string}' do |dir|
  cmd_bit_reporting_false = "bash -c '" \
      "HOME=#{aruba.config.home_directory} bit config --skip-update set analytics_reporting false && " \
      "HOME=#{aruba.config.home_directory} bit config --skip-update set error_reporting false" \
      "'"

  cmd_bit_init_workspace = "bash -c '" \
      "bit init #{aruba.config.working_directory}/#{dir}" \
      "'"

  system cmd_bit_reporting_false
  system cmd_bit_init_workspace
end
