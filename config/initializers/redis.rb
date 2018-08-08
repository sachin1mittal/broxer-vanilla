def logger(name)
  Logger.new("#{Rails.root}/log/#{name}.log").tap do |logger|
    logger.formatter = proc do |severity, datetime, progname, msg|
      data = {
          '@level': severity,
          '@timestamp': datetime,
          message: msg
      }
      "#{JSON.dump(data)}\n"
    end
  end
end

# Global cache redis object
namespace = Rails.application.class.parent_name.underscore
$cache_redis_pool = ConnectionPool.new(size: Settings.CACHE.REDIS.POOL, timeout: Settings.CACHE.REDIS.TIMEOUT) {
  redis = Redis.new(host: Settings.CACHE.REDIS.HOST,
                    port: Settings.CACHE.REDIS.PORT,
                    timeout: Settings.CACHE.REDIS.TIMEOUT,
                    logger: Settings.CACHE.REDIS.LOGGING && logger(:cache_redis))
  Redis::Namespace.new(namespace, redis: redis)
}
