# frozen_string_literal: true

module Takeltau
  # tau git check
  class GitCheck < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include GitCheckClean
    include GitCheckHg
    include GitCheckWorkspace

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
    # git check hg
    #
    desc 'hg', 'Check if we are on the git hg branch'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if we are on the git hg branch
    LONGDESC
    # Check if we are on the git hg branch.
    def hg
      exit git_check_hg
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
