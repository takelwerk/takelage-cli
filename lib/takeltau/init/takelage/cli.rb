# frozen_string_literal: true

module Takeltau
  # takeltau init takelage
  class InitTakelage < SubCommandBase
    include Thor::Actions
    include LoggingModule
    include SystemModule
    include ConfigModule
    include ProjectModule
    include GitCheckClean
    include GitCheckWorkspace
    include InitLib
    include InitTakelageRake

    argument :name

    # Define templates
    # rubocop:disable Metrics/MethodLength
    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      @gitignore = {
        name: '.gitignore',
        template: '../templates/gitignore.tt'
      }
      @hgclone = {
        name: 'hgclone',
        template: 'templates/hgclone.tt'
      }
      @projectyml = {
        name: 'project.yml',
        template: 'templates/projectyml.tt'
      }
      @rakefile = {
        name: 'Rakefile',
        template: '../templates/Rakefile.tt'
      }
    end
    # rubocop:enable Metrics/MethodLength

    # Provide template path for Thor:Actions
    def self.source_root
      File.dirname(__FILE__)
    end

    #
    # init takelage rake
    #
    desc 'rake [NAME]', 'Initialize takelage rake project [NAME]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Initialize takelage rake project [NAME]
    LONGDESC
    # Initialize takelage rake project [NAME].
    def rake
      exit init_takelage_rake
    end
  end
end
