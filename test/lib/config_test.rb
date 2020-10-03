require "test_helper"

class ConfigTest < Minitest::Test
  def setup
    @config = Object.new
    @config.extend(ConfigModule)
    @config.extend(LoggingModule)
    @config.extend(SystemModule)
    @config.log.level = Logger::FATAL
    @config.initialize_config
  end

  def test_detect_configured_key
    assert @config.configured? %w[info_project_main]
  end

  def test_detect_unconfigured_key
    refute @config.configured? %w[unconfigured_key]
  end
end
