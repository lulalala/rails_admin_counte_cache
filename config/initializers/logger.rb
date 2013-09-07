# http://cbpowell.wordpress.com/2012/04/05/beautiful-logging-for-ruby-on-rails-3-2/
if Rails.env.development?
  class ActiveSupport::BufferedLogger
    def formatter=(formatter)
      @log.formatter = formatter
    end
  end

  class Formatter
    SEVERITY_TO_COLOR_MAP   = {'DEBUG'=>'0;37', 'INFO'=>'32', 'WARN'=>'33', 'ERROR'=>'31', 'FATAL'=>'31', 'UNKNOWN'=>'37'}

    def call(severity, time, progname, msg)
      formatted_severity = sprintf("%-5s","#{severity}")

      #formatted_time = time.strftime("%Y-%m-%d %H:%M:%S.") << time.usec.to_s[0..2].rjust(3)
      color = SEVERITY_TO_COLOR_MAP[severity]

      "[\033[#{color}m#{formatted_severity}\033[0m] #{msg.strip} (pid:#{$$})\n"
    end

  end

  Rails.logger.formatter = Formatter.new

end

# Custom logger
require 'singleton'
class PaymentLogger < Logger
  include Singleton

  class Formatter
    def call(severity, time, progname, msg)
      formatted_severity = sprintf("%-5s",severity.to_s)
      formatted_time = time.strftime("%Y-%m-%d %H:%M:%S")
      "[#{formatted_severity} #{formatted_time} #{$$}] #{msg.strip}\n"
    end
  end

  def initialize
    super(Rails.root.join('log/payment.log'))
    self.formatter = Formatter.new
    self
  end

  def self.error(msg); instance.error(msg) end
  def self.debug(msg); instance.debug(msg) end
  def self.fatal(msg); instance.fatal(msg) end
  def self.info(msg); instance.info(msg) end
  def self.warn(msg); instance.warn(msg) end
end
