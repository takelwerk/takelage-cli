# frozen_string_literal: true

module Takeltau
  # tau docker check
  class DockerCheck < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon

    #
    # docker check daemon
    #
    desc 'daemon', 'Check if docker daemon is running'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if docker daemon is running
    LONGDESC
    # Check if docker daemon is running.
    def daemon
      exit docker_check_daemon
    end
  end
end
