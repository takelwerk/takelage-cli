# frozen_string_literal: true

module Takelage
  # takelage docker check
  class DockerCheck < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon
    include DockerCheckSocat

    #
    # docker check daemon
    #
    desc 'daemon', 'Check if docker daemon is running'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if docker daemon is running
    LONGDESC
    # Check if docker daemon is running.
    def running
      exit docker_check_daemon
    end

    #
    # docker check socat
    #
    desc 'socat', 'Check if socat command is available'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if socat command is available
    LONGDESC
    # Check if socat command is available.
    def running
      exit docker_check_socat
    end
  end
end
