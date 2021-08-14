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

require_relative 'takeltau/lib/logging'
require_relative 'takeltau/lib/subcmd'
require_relative 'takeltau/lib/system'
require_relative 'takeltau/lib/config'
require_relative 'takeltau/lib/project'

require_relative 'takeltau/git/check/clean'
require_relative 'takeltau/git/check/bit'
require_relative 'takeltau/git/check/workspace'
require_relative 'takeltau/git/check/cli'
require_relative 'takeltau/git/cli'
require_relative 'takeltau/bit/check/workspace'
require_relative 'takeltau/bit/check/cli'
require_relative 'takeltau/bit/scope/add'
require_relative 'takeltau/bit/scope/ssh'
require_relative 'takeltau/bit/scope/list'
require_relative 'takeltau/bit/scope/new'
require_relative 'takeltau/bit/scope/cli'
require_relative 'takeltau/bit/clipboard/lib'
require_relative 'takeltau/bit/clipboard/copy'
require_relative 'takeltau/bit/clipboard/paste'
require_relative 'takeltau/bit/clipboard/pull'
require_relative 'takeltau/bit/clipboard/push'
require_relative 'takeltau/bit/clipboard/cli'
require_relative 'takeltau/bit/require/lib'
require_relative 'takeltau/bit/require/export'
require_relative 'takeltau/bit/require/import'
require_relative 'takeltau/bit/require/cli'
require_relative 'takeltau/bit/cli'
require_relative 'takeltau/completion/cli'
require_relative 'takeltau/init/lib'
require_relative 'takeltau/init/packer/docker'
require_relative 'takeltau/init/packer/cli'
require_relative 'takeltau/init/takelage/rake'
require_relative 'takeltau/init/takelage/cli'
require_relative 'takeltau/init/cli'
require_relative 'takeltau/mutagen/check/daemon'
require_relative 'takeltau/mutagen/socket/check'
require_relative 'takeltau/mutagen/socket/create'
require_relative 'takeltau/mutagen/socket/terminate'
require_relative 'takeltau/mutagen/socket/tidy'
require_relative 'takeltau/docker/check/daemon'
require_relative 'takeltau/docker/check/cli'
require_relative 'takeltau/docker/image/tag/list'
require_relative 'takeltau/docker/image/tag/latest'
require_relative 'takeltau/docker/image/tag/check'
require_relative 'takeltau/docker/image/tag/cli'
require_relative 'takeltau/docker/image/update'
require_relative 'takeltau/docker/image/cli'
require_relative 'takeltau/docker/container/check/existing'
require_relative 'takeltau/docker/container/check/network'
require_relative 'takeltau/docker/container/check/orphaned'
require_relative 'takeltau/docker/container/check/cli'
require_relative 'takeltau/docker/container/lib'
require_relative 'takeltau/docker/container/command'
require_relative 'takeltau/docker/container/daemon'
require_relative 'takeltau/docker/container/login'
require_relative 'takeltau/docker/container/clean'
require_relative 'takeltau/docker/container/prune'
require_relative 'takeltau/docker/container/cli'
require_relative 'takeltau/docker/cli'
require_relative 'takeltau/mutagen/check/cli'
require_relative 'takeltau/mutagen/socket/list'
require_relative 'takeltau/mutagen/socket/cli'
require_relative 'takeltau/mutagen/cli'
require_relative 'takeltau/info/status/lib'
require_relative 'takeltau/info/status/git'
require_relative 'takeltau/info/status/gopass'
require_relative 'takeltau/info/status/gpg'
require_relative 'takeltau/info/status/ssh'
require_relative 'takeltau/info/status/bar'
require_relative 'takeltau/info/status/cli'
require_relative 'takeltau/info/project/cli'
require_relative 'takeltau/info/cli'
require_relative 'takeltau/self/config/cli'
require_relative 'takeltau/self/list'
require_relative 'takeltau/self/cli'

# Facilitate the takelage devops workflow.
module Takeltau
  # takeltau
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

    desc 'init [COMMAND] ', 'Init projects'
    subcommand 'init', Init

    desc 'mutagen [COMMAND] ', 'Manage mutagen'
    subcommand 'mutagen', Mutagen

    desc 'self [COMMAND] ', 'Manage takelage tools'
    subcommand 'self', Self

    #
    # Top-level commands
    #

    desc 'config', 'Alias for tau self config active'
    # takeltau config: {takelage::SelfConfig#active}
    def config
      Takeltau::SelfConfig.new.active
    end

    desc 'copy [DIR] [SCOPE]', 'Alias for tau bit clipboard copy'
    # takeltau copy: {takelage::BitClipboard#copy}
    def copy(dir_or_file, scope)
      Takeltau::BitClipboard.new.copy dir_or_file, scope
    end

    desc 'project', 'Alias for tau info project active'
    # takeltau project: {takelage::InfoProject#active}
    def project
      Takeltau::InfoProject.new.active
    end

    desc 'login', 'Alias for tau docker container login'
    # takeltau login: {takelage::DockerContainer#login}
    def login
      Takeltau::DockerContainer.new.login
    end

    desc 'list', 'Alias for tau self list'
    # takeltau version: {takelage::Self#list}
    def list
      Takeltau::Self.new.list
    end

    desc 'clean', 'Alias for tau docker container clean'
    # takeltau clean: {takelage::DockerContainer#clean}
    def clean
      Takeltau::DockerContainer.new.clean
    end

    desc 'paste [COMPONENT] [DIR]', 'Alias for tau bit clipboard paste'
    # takeltau paste: {takelage::BitClipboard#paste}
    def paste(cid, dir)
      Takeltau::BitClipboard.new.paste cid, dir
    end

    desc 'pull', 'Alias for tau bit clipboard pull'
    # takeltau pull: {takelage::BitClipboard#pull}
    def pull
      Takeltau::BitClipboard.new.pull
    end

    desc 'prune', 'Alias for tau docker container prune'
    # takeltau prune: {takelage::DockerContainer#prune}
    def prune
      Takeltau::DockerContainer.new.prune
    end

    desc 'push', 'Alias for tau bit clipboard push'
    # takeltau push: {takelage::BitClipboard#push}
    def push
      Takeltau::BitClipboard.new.push
    end

    desc 'status', 'Alias for tau info status bar'
    # takeltau status: {takelage::InfoStatus#bar}
    def status
      Takeltau::InfoStatus.new.bar
    end

    desc 'update', 'Alias for tau docker image update'
    # takeltau update: {takelage::DockerImage#update}
    def update
      Takeltau::DockerImage.new.update
    end

    desc 'version', 'Alias for tau self version'
    # takeltau version: {takelage::Self#version}
    def version
      Takeltau::Self.new.version
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
