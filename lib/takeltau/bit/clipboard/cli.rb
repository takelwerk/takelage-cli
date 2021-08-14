# frozen_string_literal: true

module Takeltau
  # takeltau bit clipboard
  class BitClipboard < SubCommandBase
    include LoggingModule
    include ConfigModule
    include SystemModule
    include GitCheckClean
    include GitCheckBit
    include GitCheckWorkspace
    include BitCheckWorkspace
    include BitClipboardLib
    include BitClipboardCopy
    include BitClipboardPaste
    include BitClipboardPull
    include BitClipboardPush

    #
    # bit copy
    #
    desc 'copy [DIR] [SCOPE]', 'Copy new [DIR] to [SCOPE]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Copy a directory as a bit component to a bit remote scope
    This command will add a directory as a bit component and tag it.
    The id of the component will be created from the directory name.
    The directory needs to contain a README.bit file
    or else a new README.bit file will be created.
    The README.bit will be the main file of the component which must not be deleted.
    The tagged bit component will be exported to a bit remote scope.
    LONGDESC
    # Copy a file or directory as a bit component to a bit remote scope.
    def copy(dir_or_file, scope)
      exit bit_clipboard_copy dir_or_file, scope
    end

    #
    # bit paste
    #
    desc 'paste [COMPONENT] [DIR]', 'Paste bit [COMPONENT] into [DIR]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Paste a bit component into a directory
    LONGDESC
    # Paste a bit component into a directory.
    def paste(cid, dir)
      exit bit_clipboard_paste cid, dir
    end

    #
    # bit pull
    #
    desc 'pull', 'Pull all updates for bit components from bit remote scopes'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Pull all updates for bit components from bit remote scopes
    LONGDESC
    # Pull all updates for bit components from bit remote scopes.
    def pull
      exit bit_clipboard_pull
    end

    #
    # bit push
    #
    desc 'push', 'Push all updates of bit components to bit remote scopes'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Push all updates of bit components to bit remote scopes
    LONGDESC
    # Push all updates of bit components to bit remote scopes.
    def push
      exit bit_clipboard_push
    end
  end
end
