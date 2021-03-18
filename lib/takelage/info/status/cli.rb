# frozen_string_literal: true

module Takelage
  # takelage info status
  class InfoStatus < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerSocketScheme
    include GitCheckWorkspace
    include InfoStatusLib
    include InfoStatusGit
    include InfoStatusGopass
    include InfoStatusGPG
    include InfoStatusSSH
    include InfoStatusBar

    #
    # info status bar
    #
    desc 'bar', 'Print status info bar'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print status info bar
    LONGDESC
    # Print status info bar.
    def bar
      say info_status_bar
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
