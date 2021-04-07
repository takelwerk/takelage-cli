# frozen_string_literal: true

module Takelage
  # takelage git check
  class GitCheck < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include GitCheckClean
    include GitCheckBit
    include GitCheckWorkspace

    #
    # git check bit
    #
    desc 'bit', 'Check if we are on the git bit branch'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if we are on the git bit branch
    LONGDESC
    # Check if we are on the git bit branch.
    def bit
      exit git_check_bit
    end

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
