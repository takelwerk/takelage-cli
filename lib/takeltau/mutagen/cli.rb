# frozen_string_literal: true

module Takeltau
  # tau mutagen
  class Mutagen < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon
    include DockerContainerLib
    include MutagenCheckDaemon

    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      log.debug 'Check docker dameon for mutagen subcommand'
      exit false unless docker_check_daemon

      log.debug 'Check mutagen dameon for mutagen subcommand'
      exit false unless mutagen_check_daemon
    end

    desc 'check [COMMAND]', 'Check mutagen'
    subcommand 'check', MutagenCheck

    desc 'socket [COMMAND]', 'Manage mutagen socket'
    subcommand 'socket', MutagenSocket
  end
end
