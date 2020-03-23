module Takelage

  # takelage info project
  class InfoProject < SubCommandBase

    include LoggingModule
    include SystemModule
    include ConfigModule
    include ProjectModule

    #
    # info project active
    #
    desc 'active', 'Print active project info'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print active project info
    LONGDESC
    # Print active project info.
    def active
      say hash_to_yaml(project.active)
    end

    #
    # info project private
    #
    desc 'private', 'Print private project info'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print private project info
    LONGDESC
    # Print private project info.
    def private
      say hash_to_yaml(project.private)
    end

    #
    # info project main
    #
    desc 'main', 'Print main project info'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Print main project info
    LONGDESC
    # Print main project info.
    def main
      say hash_to_yaml(project.main)
    end
  end
end
