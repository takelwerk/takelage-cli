# frozen_string_literal: true

require "test_helper"

class InfoProjectTest < Minitest::Test
  def setup
    @project = Object.new
    @project.extend(LoggingModule)
    @project.extend(SystemModule)
    @project.extend(ConfigModule)
    @project.extend(ProjectModule)
    @project.log.level = Logger::FATAL
  end

  def test_that_project_private_beats_main
    @project.stub :_project_read_main, {'food' => 'banana'} do
      @project.stub :_project_read_private, {'food' => 'tomato'} do
        @project.initialize_project
        assert_equal 'tomato', @project.project.active['food']
      end
    end
  end

  def test_that_gopass_secrets_are_resolved
    @project.stub :_project_read_main, {'my_secret_var' => 'pass(my_project/my_secret_key)'} do
      assert_equal 'my_secret_value', @project.project.active['my_secret_var']
    end
  end
end
