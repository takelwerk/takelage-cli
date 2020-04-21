# frozen_string_literal: true

require 'pathname'
require 'open3'
require 'yaml'

# Interaction with the operating system
module SystemModule
  def hash_to_yaml(hash)
    return nil.to_yaml if hash == {}

    hash.to_yaml({ line_width: -1 })
  end

  # @return [Hash] content of yaml file
  def read_yaml_file(file)
    log.debug "Reading YAML file \"#{file}\""
    return nil unless _file_exists? file
    return nil unless _file_read file
    return nil unless _parse_yaml @content_yaml

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
    stdout_str, = Open3.capture3 command
    log.debug "Command \"#{command}\" has stdout:\n\"\"\"\n#{stdout_str}\"\"\""
    stdout_str
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
    _, _, status = Open3.capture3 command
    log.debug "Command \"#{command}\" has exit status \"#{status.exitstatus}\""
    status
  end

  private

  # Check if file exists.
  def _file_exists?(file)
    unless File.exist? file
      log.debug "File \"#{file}\" doesn't exist"
      return false
    end
    true
  end

  # Read YAML file.
  def _file_read(file)
    begin
      @content_yaml = File.read file
    rescue SystemCallError
      log.debug "Unable to read file \"#{file}\""
      return false
    end
    true
  end

  # Parse YAML file.
  def _parse_yaml(content_yaml)
    begin
      @content = YAML.safe_load content_yaml
    rescue Psych::SyntaxError
      log.debug "Invalid YAML file \"#{file}\""
      log.debug "Try: yamllint #{file}"
      return false
    end
    true
  end
end
