module Takelage

  # takelage bit
  class SelfConfig < SubCommandBase

    include LoggingModule
    include SystemModule
    include ConfigModule

    #
    # config defaults
    #
    desc 'default', 'Print takelage default configuration'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print takelage default configuration
    This command will print the takelage default configuration in YAML format.
    You can use it as a starting point for your own configuration by
    redirecting the output to your local takelage configuration file
    (which is by default ~/.takelage.yml):

    takelage self config defaults > ~/.takelage.yml
    LONGDESC
    # Print takelage default configuration.
    def default
      config_default_yaml = hash_to_yaml(config.default)
      exit false if config_default_yaml == false
      say config_default_yaml
      true
    end

    #
    # config home
    #
    desc 'home', 'Print takelage home config file configuration'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print takelage home config file configuration
    This command will print the configuration read from the takelage 
    configuration file in your home directory ~/.takelage.yml).
    LONGDESC
    # Print takelage home config file configuration.
    def home
      config_home_yaml = hash_to_yaml(config.home)
      exit false if config_home_yaml == false
      say config_home_yaml
      true
    end

    #
    # config project
    #
    desc 'project', 'Print takelage project config file configuration'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print takelage project config file configuration
    This command will print the configuration read from the takelage 
    configuration file .takelage.yml in your home directory).
    LONGDESC
    # Print takelage home config file configuration.
    def project
      config_project_yaml = hash_to_yaml(config.project)
      exit false if config_project_yaml == false
      say config_project_yaml
      true
    end

    #
    # config active
    #
    desc 'active', 'Print active takelage configuration'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print active takelage configuration
    This command will print the configuration read from the takelage 
    configuration file (which is by default ~/.takelage.yml).
    LONGDESC
    # Print active takelage configuration.
    def active
      config_active_yaml = hash_to_yaml(config.active)
      exit false if config_active_yaml == false
      say config_active_yaml
      true
    end
  end
end
