# frozen_string_literal: true

# Thor with subcommands that work correctly with help
class SubCommandBase < Thor
  # Set the subcommand banner.
  # rubocop:disable Style/OptionalBooleanParameter
  def self.banner(command, _namespace = nil, _subcommand = false)
    "#{basename} #{subcommand_prefix} #{command.usage}"
  end
  # rubocop:enable Style/OptionalBooleanParameter

  # Set the subcommand prefix.
  def self.subcommand_prefix
    name.gsub(/.*::/, '')
        .gsub(/^[A-Z]/) { |match| match[0].downcase }
        .gsub(/[A-Z]/) { |match| " #{match[0].downcase}" }
  end
end
