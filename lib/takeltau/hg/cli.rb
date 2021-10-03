# frozen_string_literal: true

module Takeltau
  # tau hg
  class Hg < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include GitCheckClean
    include GitCheckHg
    include GitCheckWorkspace
    include GitLib
    include HgExport
    include HgPull
    include HgPush

    #
    # hg export
    #
    desc 'export', 'Export hg repos'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Export hg repos
    LONGDESC
    # Export hg repos.
    def export
      hgclone = hg_export
      exit false if hgclone == false
      say hgclone
      true
    end

    #
    # hg pull
    #
    desc 'pull', 'Pull hg repos'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Pull hg repos
    LONGDESC
    # Pull hg repos.
    def pull
      exit hg_pull
    end

    #
    # hg push
    #
    desc 'push', 'Push hg repos'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Push hg repos
    LONGDESC
    # Push hg repos.
    def push
      exit hg_push
    end
  end
end
