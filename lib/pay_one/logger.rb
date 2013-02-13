##
# Logger class
# 
# Class provides simple logging functionallity based on standard logger.
##
module PayOne
  class Logger
    include Singleton
    
    # Native logger object
    attr_reader :native_logger
    
    # Sets initial data.
    def initialize
      @native_logger = ::Logger.new Spree::Config[:payone_logger_filepath]
    end
    
    # DB logger enabled/disabled.
    def db_enabled?
      Spree::Config[:payone_db_logging_enabled]
    end
    
    # File logger enabled/disabled.
    def file_enabled?
      Spree::Config[:payone_file_logging_enabled]
    end
    
    # Logs if logging enabled.
    def log level, message
      timestamp = Time.now.utc.to_s
      # Retrieving new connection moved to PayoneLog definition
      ActiveRecord::Base.connection_pool.with_connection do |connection|
        # db logger
        if db_enabled?
          sql = 
            "INSERT INTO spree_payone_logs (`level`, `message`, `created_at`, `updated_at`)
             VALUES ('#{level.to_s.upcase}', '#{message}', '#{timestamp}', '#{timestamp}')"
          connection.execute sql
        end
      end
      
      # file logger
      if file_enabled?
        native_logger.debug '[' + timestamp + '] ' + level.to_s.upcase + ' -- : ' + message
      end
    end
    
    # Logs debug message.
    def debug message
      self.log :debug, message
    end
    
    # Logs error message.
    def error message
      self.log :error, message
    end
    
    # Logs fatal message.
    def fatal message
      self.log :fatal, message
    end
    
    # Logs info message.
    def info message
      self.log :info, message
    end
    
    # Logs warn message.
    def warn message
      self.log :warn, message
    end
    
    # Logs debug message.
    def self.debug message
      PayOne::Logger.instance.debug message
    end
    
    # Logs error message.
    def self.error message
      PayOne::Logger.instance.error message
    end
    
    # Logs fatal message.
    def self.fatal message
      PayOne::Logger.instance.fatal message
    end
    
    # Logs info message.
    def self.info message
      PayOne::Logger.instance.info message
    end
    
    # Logs warn message.
    def self.warn message
      PayOne::Logger.instance.warn message
    end
  end
end