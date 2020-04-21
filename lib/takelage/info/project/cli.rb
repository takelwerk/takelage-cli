# frozen_string_literal: true

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
      project_active_yaml = hash_to_yaml(project.active)
      exit false if project_active_yaml == false
      say project_active_yaml
      true
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
      project_private_yaml = hash_to_yaml(project.private)
      exit false if project_private_yaml == false
      say project_private_yaml
      true
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
      project_main_yaml = hash_to_yaml(project.main)
      exit false if project_main_yaml == false
      say project_main_yaml
      true
    end
  end
end
