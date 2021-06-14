# frozen_string_literal: true

module Takelage
  # takelage init takelage
  class InitTakelage < SubCommandBase
    include Thor::Actions
    include LoggingModule
    include SystemModule
    include ConfigModule
    include ProjectModule
    include GitCheckClean
    include GitCheckBit
    include GitCheckWorkspace
    include BitCheckWorkspace
    include BitClipboardLib
    include BitClipboardCopy
    include BitClipboardPaste
    include BitRequireLib
    include BitRequireImport
    include InitLib
    include InitTakelageRake

    argument :name

    # Initialize bit require
    # Define templates
    # rubocop:disable Metrics/MethodLength
    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      @bit_require_file = config.active['bit_require_file']

      @bitrequireyml = {
        name: 'bitrequire.yml',
        template: 'templates/bitrequireyml.tt'
      }
      @gitignore = {
        name: '.gitignore',
        template: '../templates/gitignore.tt'
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
