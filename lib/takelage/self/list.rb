# frozen_string_literal: true

# takelage self list
module SelfList
  # Backend method for config self.
  def self_list
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
    tau_list = thor_list.gsub("takelage\n", '')
    tau_list.gsub!("------\n", '')
    tau_list.gsub!('thor ', 'tau ')
    tau_list.gsub!(/(.*)takelage:c_l_i:(.*)#(.*)/, '\1\2               #\3')
    tau_list.gsub!(/.*COMMAND.*\n/, '')
  end
end
