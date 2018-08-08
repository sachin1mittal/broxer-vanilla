class RestClientLogger
  LOGGER = Logger.new("#{Rails.root}/log/api.log")
  LOGGER.formatter = proc do |severity, datetime, progname, msg|
    "#{JSON.dump(msg)}\n" rescue "#{msg}\n"
  end

  def self.log(data)
    LOGGER.info(data)
  end
end
