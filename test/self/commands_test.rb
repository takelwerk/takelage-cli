# frozen_string_literal: true

require 'test_helper'

class SelfCommandsTest < Minitest::Test
  # rubocop:disable Metrics/MethodLength
  def setup
    @thor_list = %(
      takeltau
      --------
      thor self help [COMMAND]                          # Describe subcommands or one specific subcommand
      thor self commands                                # List all commands
      thor self version                                 # Print takeltau semantic version number
      thor takeltau:c_l_i:self [COMMAND]                # Manage takeltau tools
      thor takeltau:c_l_i:version                       # Alias for tau self version
    )
    @expected_output = %(
      tau self commands                                # List all commands
      tau self version                                 # Print takeltau semantic version number
      tau version                                      # Alias for tau self version
    )
    @self_commands = Object.new
    @self_commands.extend(SelfCommands)
  end
  # rubocop:enable Metrics/MethodLength

  def test_that_it_manipulates_output_of_thor_list
    @self_commands.stub :_get_thor_list_, @thor_list do
      commands_output = @self_commands.self_commands
      assert_equal @expected_output, commands_output
    end
  end
end
