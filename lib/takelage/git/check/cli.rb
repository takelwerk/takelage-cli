# frozen_string_literal: true

module Takelage
  # takelage git check
  class GitCheck < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include GitCheckModule

    #
    # git check clean
    #
    desc 'clean', 'Check if the git workspace is clean'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if the git workspace is clean
    LONGDESC
    # Check if the git workspace is clean.
    def clean
      exit git_check_clean
    end

    #
    # git check master
    #
    desc 'master', 'Check if we are on the git master branch'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if we are on the git master branch
    LONGDESC
    # Check if we are on the git master branch.
    def master
      exit git_check_master
    end

    #
    # git check workspace
    #
    desc 'workspace', 'Check if a git workspace exists'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if a git workspace exists
    LONGDESC
    # Check if a git workspace exists.
    def workspace
      exit git_check_workspace
    end
  end
end
