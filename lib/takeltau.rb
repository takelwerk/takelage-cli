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

require_relative 'takeltau/completion/cli'
require_relative 'takeltau/git/check/clean'
require_relative 'takeltau/git/check/hg'
require_relative 'takeltau/git/check/workspace'
require_relative 'takeltau/git/check/cli'
require_relative 'takeltau/git/lib'
require_relative 'takeltau/git/cli'
require_relative 'takeltau/hg/list'
require_relative 'takeltau/hg/pull'
require_relative 'takeltau/hg/push'
require_relative 'takeltau/hg/cli'
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
require_relative 'takeltau/self/commands'
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

    desc 'completion [COMMAND] ', 'Print shell completion code'
    subcommand 'completion', Completion

    desc 'docker [COMMAND] ', 'Manage docker containers'
    subcommand 'docker', Docker

    desc 'git [COMMAND] ', 'Manage git'
    subcommand 'git', Git

    desc 'hg [COMMAND] ', 'Manage hg'
    subcommand 'hg', Hg

    desc 'info [COMMAND] ', 'Get information'
    subcommand 'info', Info

    desc 'init [COMMAND] ', 'Init project'
    subcommand 'init', Init

    desc 'mutagen [COMMAND] ', 'Manage mutagen'
    subcommand 'mutagen', Mutagen

    desc 'self [COMMAND] ', 'Manage takelage tools'
    subcommand 'self', Self

    #
    # Top-level commands
    #

    desc 'clean', 'Alias for tau docker container clean'
    # tau clean: {Takeltau::DockerContainer#clean}
    def clean
      Takeltau::DockerContainer.new.clean
    end

    desc 'config', 'Alias for tau self config active'
    # tau config: {Takeltau::SelfConfig#active}
    def config
      Takeltau::SelfConfig.new.active
    end

    desc 'login', 'Alias for tau docker container login'
    # tau login: {Takeltau::DockerContainer#login}
    def login
      Takeltau::DockerContainer.new.login
    end

    desc 'commands', 'Alias for tau self commands'
    # tau version: {Takeltau::Self#commands}
    def commands
      Takeltau::Self.new.commands
    end

    desc 'project', 'Alias for tau info project active'
    # tau project: {Takeltau::InfoProject#active}
    def project
      Takeltau::InfoProject.new.active
    end

    desc 'prune', 'Alias for tau docker container prune'
    # tau prune: {Takeltau::DockerContainer#prune}
    def prune
      Takeltau::DockerContainer.new.prune
    end

    desc 'status', 'Alias for tau info status bar'
    # tau status: {Takeltau::InfoStatus#bar}
    def status
      Takeltau::InfoStatus.new.bar
    end

    desc 'update', 'Alias for tau docker image update'
    # tau update: {Takeltau::DockerImage#update}
    def update
      Takeltau::DockerImage.new.update
    end

    desc 'version', 'Alias for tau self version'
    # tau version: {Takeltau::Self#version}
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
