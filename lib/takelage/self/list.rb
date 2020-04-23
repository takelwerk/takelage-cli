# frozen_string_literal: true

# takelage self list
module SelfList
  # Backend method for config self.
  def self_list
    # use Thorfile which requires relative takelage.rb
    thorfile_dir = "#{File.dirname(__FILE__)}/../"

    # use thor list to get the list of commands and subcommands
    cmd_thor_list = "bash -c '" \
        "cd #{thorfile_dir} && " \
        'thor list' \
        "'"
    thor_list = `#{cmd_thor_list}`

    # manipulate thor list output
    _manipulate_output_(thor_list)
  end

  private

  def _manipulate_output_(thor_list)
    thor_list.gsub!("takelage\n", '')
    thor_list.gsub!("------\n", '')
    thor_list.gsub!('thor ', 'tau ')
    thor_list.gsub!(/(.*)takelage:c_l_i:(.*)#(.*)/, '\1\2               #\3')
    thor_list.gsub!(/.*COMMAND.*\n/, '')
  end
end
