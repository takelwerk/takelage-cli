# frozen_string_literal: true

require 'test_helper'

class ConfigTest < Minitest::Test
  def setup
    @config = Object.new
    @config.extend(LoggingModule)
    @config.extend(SystemModule)
    @config.extend(ConfigModule)
    @config.log.level = Logger::FATAL
  end

  def test_that_it_detects_configured_key
    @config.initialize_config
    assert @config.configured? %w[info_project_main]
  end

  def test_that_it_detects_unconfigured_key
    @config.initialize_config
    refute @config.configured? %w[unconfigured_key]
  end

  def test_that_config_home_beats_default
    @config.stub :_config_read_home, { 'info_project_main' => 'banana' } do
      @config.initialize_config
      assert_equal 'banana', @config.config.active['info_project_main']
    end
  end

  def test_that_config_project_beats_default
    @config.stub :_config_read_project, { 'info_project_main' => 'tomato' } do
      @config.initialize_config
      assert_equal 'tomato', @config.config.active['info_project_main']
    end
  end

  def test_that_config_project_beats_home
    @config.stub :_config_read_home, { 'info_project_main' => 'banana' } do
      @config.stub :_config_read_project, { 'info_project_main' => 'tomato' } do
        @config.initialize_config
        assert_equal 'tomato', @config.config.active['info_project_main']
      end
    end
  end
end
