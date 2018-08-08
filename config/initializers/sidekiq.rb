require 'sidekiq'

redis = Redis.new(host: Settings.SIDEKIQ.REDIS.HOST, port: Settings.SIDEKIQ.REDIS.PORT)
namespace = "#{Rails.application.class.parent_name.underscore}_sidekiq"
$sidekiq_redis = Redis::Namespace.new(namespace, redis: redis)

# Redis configuration
redis_conn = proc {
  redis = Redis.new(host: Settings.SIDEKIQ.REDIS.HOST, port: Settings.SIDEKIQ.REDIS.PORT)
  Redis::Namespace.new(namespace, redis: redis)
}

Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: Settings.SIDEKIQ.SERVER.REDIS.POOL, &redis_conn)

  schedule_file = 'config/sidekiq_schedule.yml'
  if File.exists?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: Settings.SIDEKIQ.CLIENT.REDIS.POOL, &redis_conn)
end

# Sidekiq::Extensions.enable_delay!
