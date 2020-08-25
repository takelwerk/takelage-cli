# frozen_string_literal: true

# takelage logging module
module LoggingModule
  # takelage logger
  class TakelageLogger
    include Singleton

    attr_accessor :logger

    def initialize
      @logger = Logger.new(STDOUT)
    end
  end

  # Initialize logger with loglevel.
  def initialize_logging(loglevel)
    TakelageLogger.instance.logger.formatter = _logging_get_log_format
    log_level_in_use = _logging_get_log_level loglevel
    TakelageLogger.instance.logger.level = log_level_in_use
    TakelageLogger.instance.logger.debug "Using loglevel #{log_level_in_use}"
  end

  # @return [Object] global singleton logger
  def log
    TakelageLogger.instance.logger
  end

  private

  # Get log format.
  def _logging_get_log_format
    proc do |severity, _datetime, _progname, msg|
      "[#{severity}] #{msg}\n"
    end
  end

  # Get log level.
  def _logging_get_log_level(loglevel)
    if %w[FATAL ERROR WARN INFO DEBUG].include? loglevel
      loglevel
    else
      TakelageLogger.instance.logger.error 'The parameter "loglevel"' \
          ' must be one of FATAL, ERROR, WARN, INFO, DEBUG'
      TakelageLogger.instance.logger.info 'Using loglevel INFO'
      Logger::INFO
    end
  end
end
