# frozen_string_literal: true

require 'docker_registry2'
require 'etc'
require 'fileutils'
require 'fylla'
require 'json'
require 'logger'
require 'rake'
require 'singleton'
require 'socket'
require 'thor'
require 'timeout'
require 'version_sorter'
require 'yaml'

require_relative 'takelage/lib/logging'
require_relative 'takelage/lib/subcmd'
require_relative 'takelage/lib/system'
require_relative 'takelage/lib/config'
require_relative 'takelage/lib/project'

require_relative 'takelage/git/check/module'
require_relative 'takelage/git/check/cli'
require_relative 'takelage/git/cli'
require_relative 'takelage/bit/check/module'
require_relative 'takelage/bit/check/cli'
require_relative 'takelage/bit/scope/add'
require_relative 'takelage/bit/scope/inbit'
require_relative 'takelage/bit/scope/list'
require_relative 'takelage/bit/scope/new'
require_relative 'takelage/bit/scope/cli'
require_relative 'takelage/bit/clipboard/module'
require_relative 'takelage/bit/clipboard/cli'
require_relative 'takelage/bit/cli'
require_relative 'takelage/completion/cli'
require_relative 'takelage/docker/check/module'
require_relative 'takelage/docker/check/cli'
require_relative 'takelage/docker/socket/module'
require_relative 'takelage/docker/socket/cli'
require_relative 'takelage/docker/image/tag/list/module'
require_relative 'takelage/docker/image/tag/list/cli'
require_relative 'takelage/docker/image/tag/latest/module'
require_relative 'takelage/docker/image/tag/latest/cli'
require_relative 'takelage/docker/image/tag/check/module'
require_relative 'takelage/docker/image/tag/check/cli'
require_relative 'takelage/docker/image/tag/cli'
require_relative 'takelage/docker/image/check/module'
require_relative 'takelage/docker/image/check/cli'
require_relative 'takelage/docker/image/module'
require_relative 'takelage/docker/image/cli'
require_relative 'takelage/docker/container/check/module'
require_relative 'takelage/docker/container/check/cli'
require_relative 'takelage/docker/container/module'
require_relative 'takelage/docker/container/cli'
require_relative 'takelage/docker/cli'
require_relative 'takelage/info/project/cli'
require_relative 'takelage/info/cli'
require_relative 'takelage/self/config/cli'
require_relative 'takelage/self/module'
require_relative 'takelage/self/cli'

# Facilitate the takelage devops workflow.
module Takelage
  # takelage
  class CLI < Thor
    include LoggingModule
    include SystemModule
    include ConfigModule
    include ProjectModule

    check_unknown_options!

    # @return [String] bash completion code
    attr_reader :bash_fylla

    option :loglevel,
           aliases: 'l',
           default: 'INFO',
           desc: 'One of: FATAL, ERROR, WARN, INFO, DEBUG'
    # Initialize takelage cli.
    def initialize(args = [], local_options = {}, configuration = {})
      # Initialize thor parent class
      super args, local_options, configuration

      # Initialize global singleton log
      initialize_logging options[:loglevel].to_s.upcase

      # Initialize global singleton config
      initialize_config

      # Initialize global singleton project
      initialize_project

      # prepare for the worst
      @docker_daemon_running = false

      # fylla bash completion code
      @bash_fylla = Fylla.bash_completion self
    end

    #
    # Subcommands
    #

    desc 'bit [COMMAND] ', 'Manage bit'
    subcommand 'bit', Bit

    desc 'completion [COMMAND] ', 'Print shell completion code'
    subcommand 'completion', Completion

    desc 'docker [COMMAND] ', 'Manage docker containers'
    subcommand 'docker', Docker

    desc 'git [COMMAND] ', 'Manage git'
    subcommand 'git', Git

    desc 'info [COMMAND] ', 'Get information'
    subcommand 'info', Info

    desc 'self [COMMAND] ', 'Manage takelage tools'
    subcommand 'self', Self

    #
    # Top-level commands
    #

    desc 'config', 'Alias for tau self config active'
    # takelage config: {takelage::SelfConfig#active}
    def config
      Takelage::SelfConfig.new.active
    end

    desc 'copy [DIR] [SCOPE]', 'Alias for tau bit clipboard copy'
    # takelage copy: {takelage::BitClipboard#copy}
    def copy(dir_or_file, scope)
      Takelage::BitClipboard.new.copy dir_or_file, scope
    end

    desc 'project', 'Alias for tau info project active'
    # takelage project: {takelage::InfoProject#active}
    def project
      Takelage::InfoProject.new.active
    end

    desc 'login', 'Alias for tau docker container login'
    # takelage login: {takelage::DockerContainer#login}
    def login
      Takelage::DockerContainer.new.login
    end

    desc 'list', 'Alias for tau self list'
    # takelage version: {takelage::Self#list}
    def list
      Takelage::Self.new.list
    end

    desc 'nuke', 'Alias for tau docker container nuke'
    # takelage nuke: {takelage::DockerContainer#nuke}
    def nuke
      Takelage::DockerContainer.new.nuke
    end

    desc 'paste [COMPONENT] [DIR]', 'Alias for tau bit clipboard paste'
    # takelage paste: {takelage::BitClipboard#paste}
    def paste(cid, dir)
      Takelage::BitClipboard.new.paste cid, dir
    end

    desc 'pull', 'Alias for tau bit clipboard pull'
    # takelage pull: {takelage::BitClipboard#pull}
    def pull
      Takelage::BitClipboard.new.pull
    end

    desc 'purge', 'Alias for tau docker container purge'
    # takelage purge: {takelage::DockerContainer#purge}
    def purge
      Takelage::DockerContainer.new.purge
    end

    desc 'push', 'Alias for tau bit clipboard push'
    # takelage push: {takelage::BitClipboard#push}
    def push
      Takelage::BitClipboard.new.push
    end

    desc 'update', 'Alias for tau docker image update'
    # takelage update: {takelage::DockerImage#update}
    def update
      Takelage::DockerImage.new.update
    end

    desc 'version', 'Alias for tau self version'
    # takelage version: {takelage::Self#version}
    def version
      Takelage::Self.new.version
    end

    #
    # Administrative functions
    #

    # Behave as expected by correctly reporting failure in exit status.
    # See https://github.com/erikhuda/thor/wiki/Making-An-Executable
    def self.exit_on_failure?
      true
    end
  end
end
