# frozen_string_literal: true

module Takelage
  # takelage info project
  class InitPacker < SubCommandBase
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
    include InitPackerLib
    include InitPackerDocker

    argument :name

    # Initialize bit require
    # rubocop:disable Metrics/MethodLength
    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      @bit_require_file = config.active['bit_require_file']

      @ansiblelint = {
        name: 'ansible/.ansible-lint',
        template: 'templates/ansiblelint.tt'
      }
      @bitrequireyml = {
        name: 'bitrequire.yml',
        template: 'templates/bitrequireyml.tt'
      }
      @gitignore = {
        name: '.gitignore',
        template: 'templates/gitignore.tt'
      }
      @groupvarsprojectyml = {
        name: 'ansible/group_vars/all/project.yml',
        template: 'templates/groupvarsprojectyml.tt'
      }
      @playbooksiteyml = {
        name: 'ansible/playbook-site.yml',
        template: 'templates/playbooksiteyml.tt'
      }
      @projectyml = {
        name: 'project.yml',
        template: 'templates/projectyml.tt'
      }
      @rakefile = {
        name: 'Rakefile',
        template: 'templates/Rakefile.tt'
      }
    end
    # rubocop:enable Metrics/MethodLength

    # Provide template path for Thor:Actions
    def self.source_root
      File.dirname(__FILE__)
    end

    #
    # init packer docker
    #
    desc 'docker [NAME]', 'Initialize packer project [NAME] for docker images'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Initialize packer project [NAME] for docker images
    LONGDESC
    # Initialize packer project [NAME] for docker images.
    def docker
      exit init_packer_docker
    end
  end
end
