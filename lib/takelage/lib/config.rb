# takelage config module
module ConfigModule

  # takelage config class.
  class TakelageConfig

    include LoggingModule
    include SystemModule

    attr_accessor :active, :default, :home, :project

    def initialize
      @active = Hash.new
      @default = Hash.new
      @home = Hash.new
      @project = Hash.new
    end
  end

  # Global singleton config
  @@config = TakelageConfig.new

  # Initialze config
  def initialize_config
    log.debug "takelage version: #{Takelage::VERSION}"
    log.debug "Current working directory: #{Dir.pwd}"

    # read default config file in lib
    default_file = "#{File.dirname(__FILE__)}/../default.yml"
    default_file = File.expand_path default_file
    if File.exist? default_file
      @@config.default = read_yaml_file(default_file) || Hash.new
      @@config.default = @@config.default.sort.to_h
    end

    # read custom config file in $HOME
    home_file = "#{Dir.home}/.takelage.yml"
    if File.exist? home_file
      @@config.home = read_yaml_file(home_file) || Hash.new
      @@config.home = @@config.home.sort.to_h
    end

    # read custom config file next to Rakefile
    file, path = Rake.application.find_rakefile_location
    if path
      project_file = "#{path}/takelage.yml"
      @@config.project = read_yaml_file(project_file) || Hash.new
      @@config.project = @@config.project.sort.to_h
    end

    # make a clone or else we'll change the original hash
    default = @@config.default.clone
    home = @@config.home.clone
    project = @@config.project.clone

    # merge default and home and project to active
    # project wins against home wins against default
    project_over_home = home.merge!(project)

    @@config.active = default.merge!(project_over_home)
    @@config.active = @@config.active.sort.to_h
  end

  # @return [Object] global singleton config
  def config
    @@config
  end

  # @return [Boolean] check if config keys are configured
  def configured?(config_keys)
    @configured = true
    config_keys.each do |config_key|
      unless @@config.active.key? config_key
        log.error "Please configure \"#{config_key}\""
        @configured = false
      end
    end
    @configured
  end
end
