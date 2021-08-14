# frozen_string_literal: true

# takeltau logging module
module LoggingModule
  # takeltau logger
  class TakeltauLogger
    include Singleton

    attr_accessor :logger

    def initialize
      @logger = Logger.new($stdout)
    end
  end

  # Initialize logger with loglevel.
  def initialize_logging(loglevel)
    TakeltauLogger.instance.logger.formatter = _logging_get_log_format
    log_level_in_use = _logging_get_log_level loglevel
    TakeltauLogger.instance.logger.level = log_level_in_use
    TakeltauLogger.instance.logger.debug "Using loglevel #{log_level_in_use}"
  end

  # @return [Object] global singleton logger
  def log
    TakeltauLogger.instance.logger
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
      TakeltauLogger.instance.logger.error 'The parameter "loglevel"' \
          ' must be one of FATAL, ERROR, WARN, INFO, DEBUG'
      TakeltauLogger.instance.logger.info 'Using loglevel INFO'
      Logger::INFO
    end
  end
end
