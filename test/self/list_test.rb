require "test_helper"

class SelfListTest < Minitest::Test
  def setup
    @thor_list = %{
      takelage
      --------
      thor self help [COMMAND]                          # Describe subcommands or one specific subcommand
      thor self list                                    # List all commands
      thor self version                                 # Print takelage semantic version number
      thor takelage:c_l_i:self [COMMAND]                # Manage takelage tools
      thor takelage:c_l_i:version                       # Alias for tau self version
    }
    @expected_output = %{
      tau self list                                    # List all commands
      tau self version                                 # Print takelage semantic version number
      tau version                                      # Alias for tau self version
    }
    @self_list = Object.new
    @self_list.extend(SelfList)
  end

  def test_it_manipulates_output_of_thor_list
    @self_list.stub :_get_thor_list_, @thor_list do
      list_output = @self_list.self_list
      assert_equal @expected_output, list_output
    end
  end
end
