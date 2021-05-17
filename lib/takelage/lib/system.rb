# frozen_string_literal: true

require 'pathname'
require 'open3'
require 'yaml'

# Interaction with the operating system
# rubocop:disable Metrics/ModuleLength
module SystemModule
  # Check if a command is available else log error message
  # @return [Boolean] is the command available?
  def command_available_else_error?(command)
    status = _command_available? command

    unless status.exitstatus.zero?
      log.error "The command \"#{command}\" is not available"
      return false
    end

    command_available command
  end

  # Check if a command is available else log warning message
  # @return [Boolean] is the command available?
  def command_available_else_warning?(command)
    status = _command_available? command

    unless status.exitstatus.zero?
      log.warning "The command \"#{command}\" is not available"
      return false
    end

    command_available command
  end

  # Convert hash to yaml.
  # @return [String] yaml of hash
  def hash_to_yaml(hash)
    return nil.to_yaml if hash == {}

    hash.to_yaml({ line_width: -1 })
  end

  # Read yaml file.
  # @return [Hash] content of yaml file
  def read_yaml_file(file)
    log.debug "Reading YAML file \"#{file}\""
    return nil unless _file_exists? file
    return nil unless _file_read file
    return nil unless _parse_yaml file, @content_file

    @content
  end

  # Read yaml file with erb templates.
  # @return [Hash] content of yaml file
  def read_yaml_erb_file(file)
    log.debug "Reading YAML ERB file \"#{file}\""
    return nil unless _file_exists? file
    return nil unless _file_read file
    return nil unless _parse_erb file, @content_file
    return nil unless _parse_yaml file, @content_yaml

    @content
  end

  # Remove directory tree.
  def rm_fr(directory)
    unless File.directory? directory
      log.error "Cannot remove non-existing directory \"#{directory}\""
      return
    end
    log.debug "Removing directory \"#{directory}\" recursively"
    Pathname.new(directory).rmtree
  end

  # Run a command and return the standard output.
  # @return [String] stdout of command
  def run(command)
    log.debug "Running command \"#{command}\""
    stdout_str, stderr_str, status = Open3.capture3 command
    log.debug "Command \"#{command}\" has stdout:\n\"\"\"\n#{stdout_str}\"\"\""
    log.debug "Command \"#{command}\" has stderr:\n\"\"\"\n#{stderr_str}\"\"\""
    log.debug "Command \"#{command}\" has exit status: \"#{status.exitstatus}\""
    stdout_str
  end

  # Run a command and return the standard output
  # the standard error and the exit status
  # @return [[String, String, Integer]] array of
  # stdout, stderr, exitstatus of command
  def run_and_capture(command)
    log.debug "Running amd capturing command \"#{command}\""
    stdout_str, stderr_str, status = Open3.capture3 command
    log.debug "Command \"#{command}\" has stdout:\n\"\"\"\n#{stdout_str}\"\"\""
    log.debug "Command \"#{command}\" has stderr:\n\"\"\"\n#{stderr_str}\"\"\""
    log.debug "Command \"#{command}\" has exit status: \"#{status.exitstatus}\""
    [stdout_str, stderr_str, status.exitstatus]
  end

  # Use Kernel#exec to replace the ruby process with a command.
  def run_and_exit(command)
    log.debug "Running command \"#{command}\" and exiting afterwards"
    exec command
  end

  # Use Kernel#fork and Kernel#exec to run a command as a background process.
  def run_and_fork(command)
    log.debug "Running command \"#{command}\" as a background process"
    job = fork do
      exec command
    end
    Process.detach(job)
  end

  # Run a command and return the result.
  # @return [Boolean] success of command run
  def try(command)
    log.debug "Running command \"#{command}\""
    stdout_str, stderr_str, status = Open3.capture3 command
    log.debug "Command \"#{command}\" has stdout:\n\"\"\"\n#{stdout_str}\"\"\""
    log.debug "Command \"#{command}\" has stderr:\n\"\"\"\n#{stderr_str}\"\"\""
    log.debug "Command \"#{command}\" has exit status: \"#{status.exitstatus}\""
    status
  end

  private

  # Check if command is available
  def _command_available?(command)
    return true if instance_variable_get("@command_available_#{command}")

    log.debug "Check if the command \"#{command}\" is available"

    status = try "which #{command}"

    unless status.exitstatus.zero?
      log.error "The command \"#{command}\" is not available"
      return false
    end

    log.debug "The command \"#{command}\" is available"
    instance_variable_set("@command_available_#{command}", true)
  end

  # Command is available
  def command_available(command)
    log.debug "The command \"#{command}\" is available"
    instance_variable_set("@command_available_#{command}", true)
  end

  # Check if file exists.
  def _file_exists?(file)
    unless File.exist? File.expand_path(file)
      log.debug "File \"#{file}\" doesn't exist"
      return false
    end
    true
  end

  # Read yaml file.
  def _file_read(file)
    begin
      @content_file = File.read File.expand_path(file)
    rescue SystemCallError
      log.debug "Unable to read file \"#{file}\""
      return false
    end
    true
  end

  # Parse erb file.
  def _parse_erb(file, content_erb)
    begin
      @content_yaml = ERB.new(content_erb).result
    rescue StandardError => e
      log.debug e.class
      log.debug "Invalid ERB in YAML file \"#{file}\". " \
        "#{e.class}: \"#{e.message}\""
      return false
    end
    true
  end

  # Parse yaml file.
  def _parse_yaml(file, content_yaml)
    begin
      @content = YAML.safe_load content_yaml
    rescue Psych::SyntaxError
      log.debug "Invalid YAML file \"#{file}\""
      log.debug "Try: yamllint #{file}"
      return false
    end
    true
  end

  # Pluralize a verb in relation to a number
  def pluralize(number, singular, plural)
    return singular if number == 1

    plural
  end
end
# rubocop:enable Metrics/ModuleLength
