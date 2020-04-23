# frozen_string_literal: true

module Takelage
  # takelage docker check
  class DockerCheck < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckRunning

    #
    # docker check running
    #
    desc 'running', 'Check if docker daemon is running'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if docker daemon is running
    LONGDESC
    # Check if docker daemon is running.
    def running
      exit docker_check_running
    end
  end
end
