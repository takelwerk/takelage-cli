# frozen_string_literal: true

# tau self commands
module SelfCommands
  # Backend method for config self commands.
  def self_commands
    _manipulate_output_(_get_thor_list_)
  end

  private

  # Get output of thor list command.
  def _get_thor_list_
    # use Thorfile which requires relative takelage.rb
    thorfile_dir = "#{File.dirname(__FILE__)}/../"

    # use thor list to get the list of commands and subcommands
    cmd_thor_list = "bash -c '" \
                    "cd #{thorfile_dir} && " \
                    'thor list' \
                    "'"

    # call thor list command
    `#{cmd_thor_list}`
  end

  # Manipulate output of thor list command.
  def _manipulate_output_(thor_list)
    tau_commands = thor_list.gsub("takeltau\n", '')
    tau_commands.gsub!("--------\n", '')
    tau_commands.gsub!('thor ', 'tau ')
    tau_commands.gsub!(/(.*)takeltau:c_l_i:(.*)#(.*)/, '\1\2               #\3')
    tau_commands.gsub!(/.*COMMAND.*\n/, '')
  end
end
