# Thor with subcommands that work correctly with help
class SubCommandBase < Thor

  # Set the subcommand banner
  def self.banner(command, namespace = nil, subcommand = false)
    "#{basename} #{subcommand_prefix} #{command.usage}"
  end

  # Set the subcommand prefix
  def self.subcommand_prefix
    self.name.gsub(%r{.*::}, '').gsub(%r{^[A-Z]}) { |match| match[0].downcase }.gsub(%r{[A-Z]}) { |match| " #{match[0].downcase}" }
  end
end
