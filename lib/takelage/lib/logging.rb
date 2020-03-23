# takelage logging module
module LoggingModule

  # Global singleton logger
  @@log = Logger.new(STDOUT)

  # Initialize logger with loglevel.
  def initialize_logging(loglevel)

    # logger: format
    log.formatter = proc do |severity, datetime, progname, msg|
      "[#{severity}] #{msg}\n"
    end

    # logger: level
    if %w(FATAL ERROR WARN INFO DEBUG).include? loglevel
      log.level = loglevel
      log.debug "Using loglevel #{loglevel}"
    else
      log.level = Logger::INFO
      log.error 'The parameter "loglevel" must be one of FATAL, ERROR, WARN, INFO, DEBUG'
      log.info 'Using loglevel INFO'
    end
  end

  # @return [Object] global singleton logger
  def log
    @@log
  end
end
