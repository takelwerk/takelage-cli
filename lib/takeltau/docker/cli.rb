# frozen_string_literal: true

module Takeltau
  # tau docker
  class Docker < SubCommandBase
    # Initialize docker
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon

    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      log.debug 'Check docker dameon for docker subcommand'
      exit false unless docker_check_daemon
    end

    desc 'check [COMMAND]', 'Check docker'
    subcommand 'check', DockerCheck

    desc 'container [COMMAND]', 'Handle docker container'
    subcommand 'container', DockerContainer

    desc 'image [COMMAND]', 'Handle docker images'
    subcommand 'image', DockerImage
  end
end
