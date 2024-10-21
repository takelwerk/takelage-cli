# frozen_string_literal: true

Given 'I get the active takeltau config' do
  cmd_takelage_config_active = "HOME=#{aruba.config.home_directory} " \
                               'tau-cli config'
  @config = YAML.safe_load `#{cmd_takelage_config_active}`
end
