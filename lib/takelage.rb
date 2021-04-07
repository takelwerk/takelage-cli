# frozen_string_literal: true

require 'etc'
require 'digest/bubblebabble'
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

require_relative 'takelage/git/check/clean'
require_relative 'takelage/git/check/main'
require_relative 'takelage/git/check/workspace'
require_relative 'takelage/git/check/cli'
require_relative 'takelage/git/cli'
require_relative 'takelage/bit/check/workspace'
require_relative 'takelage/bit/check/cli'
require_relative 'takelage/bit/scope/add'
require_relative 'takelage/bit/scope/ssh'
require_relative 'takelage/bit/scope/list'
require_relative 'takelage/bit/scope/new'
require_relative 'takelage/bit/scope/cli'
require_relative 'takelage/bit/clipboard/lib'
require_relative 'takelage/bit/clipboard/copy'
require_relative 'takelage/bit/clipboard/paste'
require_relative 'takelage/bit/clipboard/pull'
require_relative 'takelage/bit/clipboard/push'
require_relative 'takelage/bit/clipboard/cli'
require_relative 'takelage/bit/require/lib'
require_relative 'takelage/bit/require/export'
require_relative 'takelage/bit/require/import'
require_relative 'takelage/bit/require/cli'
require_relative 'takelage/bit/cli'
require_relative 'takelage/completion/cli'
require_relative 'takelage/mutagen/check/daemon'
require_relative 'takelage/mutagen/socket/check'
require_relative 'takelage/mutagen/socket/create'
require_relative 'takelage/mutagen/socket/terminate'
require_relative 'takelage/mutagen/socket/tidy'
require_relative 'takelage/docker/check/daemon'
require_relative 'takelage/docker/check/cli'
require_relative 'takelage/docker/image/tag/list'
require_relative 'takelage/docker/image/tag/latest'
require_relative 'takelage/docker/image/tag/check'
require_relative 'takelage/docker/image/tag/cli'
require_relative 'takelage/docker/image/update'
require_relative 'takelage/docker/image/cli'
require_relative 'takelage/docker/container/check/existing'
require_relative 'takelage/docker/container/check/network'
require_relative 'takelage/docker/container/check/orphaned'
require_relative 'takelage/docker/container/check/cli'
require_relative 'takelage/docker/container/lib'
require_relative 'takelage/docker/container/command'
require_relative 'takelage/docker/container/daemon'
require_relative 'takelage/docker/container/login'
require_relative 'takelage/docker/container/clean'
require_relative 'takelage/docker/container/prune'
require_relative 'takelage/docker/container/cli'
require_relative 'takelage/docker/cli'
require_relative 'takelage/mutagen/check/cli'
require_relative 'takelage/mutagen/socket/list'
require_relative 'takelage/mutagen/socket/cli'
require_relative 'takelage/mutagen/cli'
require_relative 'takelage/info/status/lib'
require_relative 'takelage/info/status/git'
require_relative 'takelage/info/status/gopass'
require_relative 'takelage/info/status/gpg'
require_relative 'takelage/info/status/ssh'
require_relative 'takelage/info/status/bar'
require_relative 'takelage/info/status/cli'
require_relative 'takelage/info/project/cli'
require_relative 'takelage/info/cli'
require_relative 'takelage/self/config/cli'
require_relative 'takelage/self/list'
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

      # Set defaults
      @docker_daemon_running = false
      @command_available_docker = false
      @mutagen_daemon_available = false
      @command_available_mutagen = false

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

    desc 'mutagen [COMMAND] ', 'Manage mutagen'
    subcommand 'mutagen', Mutagen

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

    desc 'clean', 'Alias for tau docker container clean'
    # takelage clean: {takelage::DockerContainer#clean}
    def clean
      Takelage::DockerContainer.new.clean
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

    desc 'prune', 'Alias for tau docker container prune'
    # takelage prune: {takelage::DockerContainer#prune}
    def prune
      Takelage::DockerContainer.new.prune
    end

    desc 'push', 'Alias for tau bit clipboard push'
    # takelage push: {takelage::BitClipboard#push}
    def push
      Takelage::BitClipboard.new.push
    end

    desc 'status', 'Alias for tau info status bar'
    # takelage status: {takelage::InfoStatus#bar}
    def status
      Takelage::InfoStatus.new.bar
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
