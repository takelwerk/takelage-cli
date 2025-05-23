# frozen_string_literal: true

require 'pathname'
require 'open3'
require 'yaml'

# Interaction with the operating system
module SystemModule
  # Check if a command is available else log error message
  # @return [Boolean] is the command available?
  def command_available_else_error?(command)
    unless _command_available? command
      log.error "The command \"#{command}\" is not available"
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
    return nil unless _parse_yaml_file file, @content_file

    @content
  end

  # Read yaml file with erb templates.
  # @return [Hash] content of yaml file
  def read_yaml_erb_file(file)
    log.debug "Reading YAML ERB file \"#{file}\""
    return nil unless _file_exists? file
    return nil unless _file_read file
    return nil unless _parse_erb_file file, @content_file
    return nil unless _parse_yaml_file file, @content_yaml

    @content
  end

  # Write content to file
  def write_file(file, content)
    log.debug "Writing content to file \"#{file}\":"
    log.debug "\"#{content}\""
    File.write(file, content)
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
    Dir.chdir(config.active['project_root_dir']) do
      log.debug "Running command \"#{command}\""
      stdout_str, stderr_str, status = Open3.capture3 command
      log.debug "Command \"#{command}\" has stdout:\n\"\"\"\n#{stdout_str}\"\"\""
      log.debug "Command \"#{command}\" has stderr:\n\"\"\"\n#{stderr_str}\"\"\""
      log.debug "Command \"#{command}\" has exit status: \"#{status.exitstatus}\""
      stdout_str
    end
  end

  # Run a command and return the standard output
  # the standard error and the exit status
  # @return [[String, String, Integer]] array of
  # stdout, stderr, exitstatus of command
  def run_and_capture(command)
    Dir.chdir(config.active['project_root_dir']) do
      log.debug "Running and capturing command \"#{command}\""
      stdout_str, stderr_str, status = Open3.capture3 command
      log.debug "Command \"#{command}\" has stdout:\n\"\"\"\n#{stdout_str}\"\"\""
      log.debug "Command \"#{command}\" has stderr:\n\"\"\"\n#{stderr_str}\"\"\""
      log.debug "Command \"#{command}\" has exit status: \"#{status.exitstatus}\""
      [stdout_str, stderr_str, status.exitstatus]
    end
  end

  # Use Kernel#exec to replace the ruby process with a command.
  def run_and_exit(command)
    Dir.chdir(config.active['project_root_dir']) do
      log.debug "Running command \"#{command}\" and exiting afterwards"
      exec command
    end
  end

  # Use Kernel#fork and Kernel#exec to run a command as a background process.
  def run_and_fork(command)
    log.debug "Running command \"#{command}\" as a background process"
    job = fork do
      Dir.chdir(config.active['project_root_dir']) do
        exec command
      end
    end
    Process.detach(job)
  end

  # Run a command and return the result.
  # @return [Boolean] success of command run
  def try(command)
    Dir.chdir(config.active['project_root_dir']) do
      log.debug "Running command \"#{command}\""
      stdout_str, stderr_str, status = Open3.capture3 command
      log.debug "Command \"#{command}\" has stdout:\n\"\"\"\n#{stdout_str}\"\"\""
      log.debug "Command \"#{command}\" has stderr:\n\"\"\"\n#{stderr_str}\"\"\""
      log.debug "Command \"#{command}\" has exit status: \"#{status.exitstatus}\""
      status
    end
  end

  private

  # Check if command is available
  def _command_available?(command)
    return true if _command_already_checked command

    log.debug "Check if the command \"#{command}\" is available"
    begin
      Dir.chdir(config.active['project_root_dir']) do
        status = try command
        return false unless status.exitstatus.zero?
      end
    rescue Errno::ENOENT => e
      log.debug 'The command failed with an error.'
      log.debug "Class of error: #{e.class}"
      log.debug "Error message: #{e.message}"
      return false
    end
    true
  end

  # Check if command has already been checked
  def _command_already_checked(command)
    digest = Digest::SHA256.bubblebabble command
    command_hash = digest[0..4]
    return true if instance_variable_get("@command_available_#{command_hash}")

    false
  end

  # Command is available
  def command_available(command)
    log.debug "The command \"#{command}\" is available"
    digest = Digest::SHA256.bubblebabble command
    command_hash = digest[0..4]
    instance_variable_set("@command_available_#{command_hash}", true)
  end

  # Check if file exists.
  def _file_exists?(file)
    unless File.exist? File.expand_path(file)
      log.debug "File \"#{file}\" doesn't exist"
      return false
    end
    true
  end

  # Read file.
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
  def _parse_erb_file(file, content_erb)
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
  def _parse_yaml_file(file, content_yaml)
    begin
      @content = YAML.safe_load content_yaml
    rescue Psych::SyntaxError
      log.debug "Invalid YAML file \"#{file}\""
      log.debug "Try: yamllint #{file}"
      return false
    end
    true
  end

  # Get yaml.
  def _parse_yaml(content_yaml)
    begin
      content = YAML.safe_load content_yaml
    rescue Psych::SyntaxError
      log.debug 'Invalid YAML'
      return false
    end
    content
  end

  # Pluralize a verb in relation to a number
  def pluralize(number, singular, plural)
    return singular if number == 1

    plural
  end
end
