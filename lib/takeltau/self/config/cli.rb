# frozen_string_literal: true

module Takeltau
  # tau self
  class SelfConfig < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule

    #
    # config defaults
    #
    desc 'default', 'Print takeltau default configuration'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print takeltau default configuration
    This command will print the takeltau default configuration in YAML format.
    You can use it as a starting point for your own configuration by
    redirecting the output to your local takeltau configuration file
    (which is by default ~/.takelage.yml):

    tau self config defaults > ~/.takelage.yml
    LONGDESC
    # Print takeltau default configuration.
    def default
      config_default_yaml = hash_to_yaml(config.default)
      exit false if config_default_yaml == false
      say config_default_yaml
      true
    end

    #
    # config home
    #
    desc 'home', 'Print takeltau home config file configuration'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print takeltau home config file configuration
    This command will print the configuration read from the takeltau
    configuration file in your home directory ~/.takeltau.yml).
    LONGDESC
    # Print takeltau home config file configuration.
    def home
      config_home_yaml = hash_to_yaml(config.home)
      exit false if config_home_yaml == false
      say config_home_yaml
      true
    end

    #
    # config project
    #
    desc 'project', 'Print takeltau project config file configuration'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print takeltau project config file configuration
    This command will print the configuration read from the takeltau
    configuration file .takeltau.yml in your home directory).
    LONGDESC
    # Print takeltau home config file configuration.
    def project
      config_project_yaml = hash_to_yaml(config.project)
      exit false if config_project_yaml == false
      say config_project_yaml
      true
    end

    #
    # config envvars
    #
    desc 'envvars', 'Print envvars takeltau configuration'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print envvars takeltau configuration
    This command will print the configuration
    read from environment variables
    LONGDESC
    # Print envvars takeltau configuration.
    def envvars
      config_envvars_yaml = hash_to_yaml(config.envvars)
      exit false if config_envvars_yaml == false
      say config_envvars_yaml
      true
    end

    #
    # config active
    #
    desc 'active', 'Print active takeltau configuration'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print active takeltau configuration
    This command will print the configuration read from the takeltau
    configuration file (which is by default ~/.takeltau.yml).
    LONGDESC
    # Print active takeltau configuration.
    def active
      config_active_yaml = hash_to_yaml(config.active)
      exit false if config_active_yaml == false
      say config_active_yaml
      true
    end
  end
end
