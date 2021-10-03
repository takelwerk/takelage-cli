# frozen_string_literal: true

module Takeltau
  # tau mutagen check
  class MutagenCheck < SubCommandBase
    include LoggingModule
    include SystemModule
    include ConfigModule
    include DockerCheckDaemon
    include DockerContainerCheckExisting
    include DockerContainerCheckNetwork
    include DockerContainerCommand
    include DockerContainerLib
    include MutagenCheckDaemon

    # Initialize mutagen check
    def initialize(args = [], local_options = {}, configuration = {})
      # initialize thor parent class
      super args, local_options, configuration

      @workdir = Dir.getwd

      inside = _docker_container_lib_check_matrjoschka
      @hostname = inside ? ENV['HOSTNAME'] : _docker_container_lib_hostname
      @hostlabel = "hostname=#{@hostname}"
    end

    #
    # mutagen check daemon
    #
    desc 'daemon', 'Check if mutagen host conenction is available'
    long_desc <<-LONGDESC.gsub("\n", "\x5")
    Check if mutagen host conenction is available
    LONGDESC
    # Check if mutagen host conenction is available.
    def daemon
      exit mutagen_check_daemon
    end
  end
end
