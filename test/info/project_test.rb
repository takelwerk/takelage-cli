# frozen_string_literal: true

require "test_helper"

class InfoProjectTest < Minitest::Test
  def setup
    @project = Object.new
    @project.extend(ProjectModule)
  end

  def test_that_project_private_beats_main
    @project.stub :_project_read_main, {'food' => 'banana'} do
      @project.stub :_project_read_private, {'food' => 'tomato'} do
        @project.initialize_project
        assert_equal 'tomato', @project.project.active['food']
      end
    end
  end
end
