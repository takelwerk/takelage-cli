# frozen_string_literal: true

# tau config module
# rubocop:disable Metrics/ModuleLength
module ConfigModule
  # tau config class.
  class TakeltauConfig
    include Singleton
    include LoggingModule
    include SystemModule

    attr_accessor :active, :default, :home, :project, :envvars

    def initialize
      @active = {}
      @default = {}
      @home = {}
      @project = {}
      @envvars = {}
    end
  end

  # Initialize config
  # rubocop:disable Metrics/AbcSize
  def initialize_config(workdir)
    project_root_dir = _get_project_root_dir workdir

    log.debug "takelage version: #{Takeltau::VERSION}"
    log.debug "Current working directory: #{Dir.pwd}"
    log.debug "Project root directory: #{project_root_dir}" unless project_root_dir.empty?

    TakeltauConfig.instance.default = _config_read_default project_root_dir
    TakeltauConfig.instance.home = _config_read_home
    TakeltauConfig.instance.project = _config_read_project project_root_dir
    TakeltauConfig.instance.envvars = _config_read_envvars
    TakeltauConfig.instance.active = _config_merge_active
  end
  # rubocop:enable Metrics/AbcSize

  # @return [Object] global singleton config
  def config
    TakeltauConfig.instance
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
    return true if TakeltauConfig.instance.active.key? config_key

    log.error "Undefined config key. Please configure \"#{config_key}\""
    @configured = false
    false
  end

  # Check if config key is nil or empty.
  def _check_key_set?(config_key)
    takel_config_key = TakeltauConfig.instance.active[config_key]
    return true unless takel_config_key.nil? || takel_config_key.empty?

    if config_key == 'project_root_dir'
      log.error 'Please create a "Rakefile" in the project root directory'
    else
      log.error "Missing config key. Please configure \"#{config_key}\""
    end
    @configured = false
    false
  end

  # Read default config file in lib.
  def _config_read_default(project_root_dir)
    default_file = File.expand_path("#{File.dirname(__FILE__)}/../default.yml")

    return { project_root_dir: project_root_dir } unless File.exist? default_file

    default_yaml = read_yaml_file(default_file) || {}

    default_yaml['project_root_dir'] = project_root_dir

    default_yaml.sort.to_h
  end

  # Read custom config file in $HOME.
  def _config_read_home
    home_file = "#{Dir.home}/.takelage.yml"

    return {} unless File.exist? home_file

    (read_yaml_file(home_file) || {}).sort.to_h
  end

  # Read custom config file in project root.
  def _config_read_project(project_root_dir)
    project_file = "#{project_root_dir}/takelage.yml"

    return {} unless File.exist? project_file

    (read_yaml_file(project_file) || {}).sort.to_h
  end

  # Read default config file in lib.
  def _config_read_envvars
    envvars_yaml = {}
    TakeltauConfig.instance.default.each_key do |key|
      envvar = "TAKELAGE_TAU_CONFIG_#{key}".upcase
      envvars_yaml[key] = ENV[envvar] if ENV.key? envvar
    end
    envvars_yaml.sort.to_h
  end

  # Merge active config.
  # rubocop:disable Metrics/AbcSize
  def _config_merge_active
    # make a clone or else we'll change the original hash
    default = TakeltauConfig.instance.default.clone
    home = TakeltauConfig.instance.home.clone
    project = TakeltauConfig.instance.project.clone
    envvars = TakeltauConfig.instance.envvars.clone

    # merge default and home and project and envvars to active
    # merge envvars over project over home over default
    envvars_over_project = project.merge!(envvars)
    project_over_home = home.merge!(envvars_over_project)
    default.merge!(project_over_home).sort.to_h
  end
  # rubocop:enable Metrics/AbcSize

  # Get project root directory.
  # @return [String] project root directory
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def _get_project_root_dir(workdir)
    tau_workdir_root_dir = _get_workdir_root_dir workdir
    unless tau_workdir_root_dir.empty?
      log.debug "CLI option workdir is set to #{tau_workdir_root_dir}"
      return tau_workdir_root_dir
    end

    if ENV.key? 'TAKELAGE_WORKDIR'
      tau_envvar_root_dir = ENV['TAKELAGE_WORKDIR']
      log.debug "TAKELAGE_WORKDIR is set to \"#{tau_envvar_root_dir}\""
      return File.expand_path tau_envvar_root_dir
    end

    tau_takelage_root_dir = _get_takelage_root_dir
    unless tau_takelage_root_dir.nil?
      log.debug "Rakefile found in \"#{tau_takelage_root_dir}\""
      return tau_takelage_root_dir
    end

    log.debug "Setting root dir to current working dir \"#{Dir.pwd}\""
    Dir.pwd
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  # Return a command line workdir
  def _get_workdir_root_dir(workdir)
    return '' unless Dir.exist? File.expand_path workdir

    p '************'
    workdir
  end

  # Return a takelage root dir
  def _get_takelage_root_dir
    _rakefile, path_rakefile = Rake.application.find_rakefile_location
    path_rakefile
  end
end
# rubocop:enable Metrics/ModuleLength
