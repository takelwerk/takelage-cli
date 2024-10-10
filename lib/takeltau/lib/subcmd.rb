# frozen_string_literal: true

# Thor with subcommands that work correctly with help
class SubCommandBase < Thor
  # Set the subcommand banner.
  # rubocop:disable Style/OptionalBooleanParameter
  def self.banner(command, _namespace = nil, _subcommand = false)
    subcommand = self.subcommand_prefix
    name = $PROGRAM_NAME
    name = ENV['TAKELAGE_TAU_TAU'] unless ENV['TAKELAGE_TAU_TAU'].nil?
    subcommand.gsub!(/ship\s*/) {} unless ENV['TAKELAGE_TAU_SHIP'].nil?
    name = File.basename(name)
    [name, subcommand, command.usage].reject(&:empty?).join(' ')
  end
  # rubocop:enable Style/OptionalBooleanParameter

  # Set the subcommand prefix.
  def self.subcommand_prefix
    name.gsub(/.*::/, '')
        .gsub(/^[A-Z]/) { |match| match[0].downcase }
        .gsub(/[A-Z]/) { |match| " #{match[0].downcase}" }
  end
end
