# frozen_string_literal: true

module Takeltau
  # takeltau init packer
  class InitPacker < SubCommandBase
    include Thor::Actions
    include LoggingModule
    include SystemModule
    include ConfigModule
    include ProjectModule
    include GitCheckClean
    include GitCheckWorkspace
    include InitLib
    include InitPackerDocker

    argument :name

    # Define templates
    # rubocop:disable Metrics/MethodLength
    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      @ansiblelint = {
        name: 'ansible/.ansible-lint',
        template: 'templates/ansiblelint.tt'
      }
      @gitignore = {
        name: '.gitignore',
        template: '../templates/gitignore.tt'
      }
      @groupvarsprojectyml = {
        name: 'ansible/group_vars/all/project.yml',
        template: 'templates/groupvarsprojectyml.tt'
      }
      @hgclone = {
        name: 'hgclone',
        template: 'templates/hgclone.tt'
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
        template: '../templates/Rakefile.tt'
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
