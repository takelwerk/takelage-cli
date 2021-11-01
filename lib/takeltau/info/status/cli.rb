# frozen_string_literal: true

module Takeltau
  # tau info status
  class InfoStatus < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon
    include DockerContainerCheckExisting
    include DockerContainerCheckNetwork
    include DockerContainerCommand
    include DockerContainerLib
    include GitCheckWorkspace
    include InfoStatusLib
    include InfoStatusGit
    include InfoStatusGopass
    include InfoStatusGPG
    include InfoStatusHg
    include InfoStatusSSH
    include InfoStatusBar
    include MutagenCheckDaemon

    # Initialize info status
    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      @workdir = Dir.getwd

      inside = _docker_container_lib_check_matrjoschka
      @hostname = inside ? ENV['HOSTNAME'] : _docker_container_lib_hostname
      @hostlabel = "hostname=#{@hostname}"
    end

    #
    # info status bar
    #
    desc 'bar', 'Print status info bar'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print status info bar
    LONGDESC
    # Print status info bar.
    def bar
      exit info_status_bar
    end

    #
    # info status git
    #
    desc 'git', 'Check git status info'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check git status info
    LONGDESC
    # Check git status info.
    def git
      exit info_status_git
    end

    #
    # info status gopass
    #
    desc 'gopass', 'Check gopass status info'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check gopass status info
    LONGDESC
    # Check gopass status info.
    def gopass
      exit info_status_gopass
    end

    #
    # info status gpg
    #
    desc 'gpg', 'Check gpg status info'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check gpg status info
    LONGDESC
    # Check gpg status info.
    def gpg
      exit info_status_gpg
    end

    #
    # info status hg
    #
    desc 'hg', 'Check hg status info'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check hg status info
    LONGDESC
    # Check hg status info.
    def hg
      exit info_status_hg
    end

    #
    # info status mutagen
    #
    desc 'mutagen', 'Check mutagen status info'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check mutagen status info
    LONGDESC
    # Check mutagen status info.
    def mutagen
      exit mutagen_check_daemon
    end

    #
    # info status ssh
    #
    desc 'ssh', 'Check ssh status info'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check ssh status info
    LONGDESC
    # Check ssh status info.
    def ssh
      exit info_status_ssh
    end
  end
end
