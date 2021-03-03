# frozen_string_literal: true

module Takelage
  # takelage bit scope
  class BitScope < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include GitCheckMain
    include GitCheckWorkspace
    include BitCheckWorkspace
    include BitScopeAdd
    include BitScopeInbit
    include BitScopeList
    include BitScopeNew

    #
    # bit scope add
    #
    desc 'add [SCOPE]', 'Add a bit [SCOPE]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Add bit remote scope
    This command will add a bit remote scope to a local bit workspace.
    The scope must exist on the bit remote server.
    LONGDESC
    # Add bit remote scope.
    def add(scope)
      exit bit_scope_add scope
    end

    #
    # bit scope new
    #
    desc 'new [SCOPE]', 'Init a new bit [SCOPE]'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Create new bit remote scope
    This command will create a new directory on the remote bit server.
    Then it will run "bit init --bare" in the newly created directory.
    See the bit documentation: http://docs.bit.dev/docs/bit-server
    LONGDESC
    # Create new bit remote scope.
    def new(scope)
      exit bit_scope_new scope
    end

    #
    # bit scope list
    #
    desc 'list', 'List bit remote scopes'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    List bit remote scopes
    This command will list bit remote scopes.
    LONGDESC
    # List bit remote scopes.
    def list
      scopes = bit_scope_list
      exit false if scopes == false
      say scopes unless scopes.to_s.chomp.empty?
      true
    end

    #
    # bit scope inbit
    #
    desc 'inbit', 'Log in to bit remote server'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Log in to bit remote server
    LONGDESC
    # Log in to bit remote server.
    def inbit
      exit bit_scope_inbit
    end
  end
end
