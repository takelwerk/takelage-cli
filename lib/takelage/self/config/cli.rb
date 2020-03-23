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
      say hash_to_yaml(config.default)
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
      say hash_to_yaml(config.home)
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
      say hash_to_yaml(config.project)
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
      say hash_to_yaml(config.active)
    end
  end
end
