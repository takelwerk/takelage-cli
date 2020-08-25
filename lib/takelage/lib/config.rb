# frozen_string_literal: true

# takelage config module
module ConfigModule
  # takelage config class.
  class TakelageConfig
    include Singleton
    include LoggingModule
    include SystemModule

    attr_accessor :active, :default, :home, :project

    def initialize
      @active = {}
      @default = {}
      @home = {}
      @project = {}
    end
  end

  # Initialze config
  # rubocop:disable Metrics/AbcSize
  def initialize_config
    log.debug "takelage version: #{Takelage::VERSION}"
    log.debug "Current working directory: #{Dir.pwd}"

    TakelageConfig.instance.default = _config_read_default
    TakelageConfig.instance.home = _config_read_home
    TakelageConfig.instance.project = _config_read_project
    TakelageConfig.instance.active = _config_merge_active
  end
  # rubocop:enable Metrics/AbcSize

  # @return [Object] global singleton config
  def config
    TakelageConfig.instance
  end

  # @return [Boolean] check if config keys are configured
  def configured?(config_keys)
    @configured = true
    config_keys.each do |config_key|
      next unless _check_key_defined? config_key
      next unless _check_key_set? config_key
    end
    @configured
  end

  private

  # Check if config key is defined.
  def _check_key_defined?(config_key)
    return true if TakelageConfig.instance.active.key? config_key

    log.error "Undefined config key. Please configure \"#{config_key}\""
    @configured = false
    false
  end

  # Check if config key is nil or empty.
  def _check_key_set?(config_key)
    takel_config_key = TakelageConfig.instance.active[config_key]
    return true unless takel_config_key.nil? || takel_config_key.empty?

    log.error "Unset config key. Please configure \"#{config_key}\""
    @configured = false
    false
  end

  # Read default config file in lib.
  def _config_read_default
    default_file = File.expand_path("#{File.dirname(__FILE__)}/../default.yml")

    return {} unless File.exist? default_file

    default_yaml = read_yaml_file(default_file) || {}

    default_yaml.sort.to_h
  end

  # Read custom config file in $HOME.
  def _config_read_home
    home_file = "#{Dir.home}/.takelage.yml"

    return {} unless File.exist? home_file

    home_yaml = read_yaml_file(home_file) || {}

    home_yaml.sort.to_h
  end

  # Read custom config file next to Rakefile.
  def _config_read_project
    _rakefile, path = Rake.application.find_rakefile_location
    project_file = "#{path}/takelage.yml"

    return {} unless File.exist? project_file

    project_yaml = read_yaml_file(project_file) || {}

    project_yaml.sort.to_h
  end

  # Merge active config.
  def _config_merge_active
    # make a clone or else we'll change the original hash
    default = TakelageConfig.instance.default.clone
    home = TakelageConfig.instance.home.clone
    project = TakelageConfig.instance.project.clone

    # merge default and home and project to active
    # project wins against home wins against default
    project_over_home = home.merge!(project)
    default.merge!(project_over_home).sort.to_h
  end
end
