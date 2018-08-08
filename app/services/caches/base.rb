module Caches
  #
  # This class is serves as a interface for cache
  #
  # @author [rohitjangid]
  class Base
    CACHE_POOL = $cache_redis_pool
    CACHE_ENABLED = Settings.CACHE.ENABLE
    KEY_PREFIX = nil

    #
    # Set cache
    #
    def self.set(key, value, options = {})
      return unless CACHE_ENABLED
      CACHE_POOL.with do |cache|
        cache.set(self.prefixed_key(key), value, redis_options(options))
      end
    end

    #
    # Return cache
    #
    def self.get(key)
      return unless CACHE_ENABLED
      CACHE_POOL.with do |cache|
        cache.get(self.prefixed_key(key))
      end
    end

    #
    # Return values for multiple keys
    # @param keys [Array] Array of keys
    #
    # @return [Array] Array of values
    def self.mget(keys)
      return [] unless CACHE_ENABLED
      prefixed_keys = keys.map { |key| self.prefixed_key(key) }
      CACHE_POOL.with do |cache|
        cache.mget(prefixed_keys)
      end
    end

    #
    # Purge all cache
    #
    def self.purge(keys = nil, strategy: :in_memory)
      case strategy
      # when :lua
      #   CACHE_POOL.with do |cache|
      #     cache.eval(
      #         "local all_keys = redis.call('keys', ARGV[1]);
      #     if table.getn(all_keys) > 0 then
      #       return redis.call('DEL', unpack(all_keys));
      #     else
      #       return 0;
      #     end
      #     ",
      #         argv: ["#{cache.namespace}:#{key_prefix}*"]
      #     )
      #   end
      when :in_memory
        keys ||= self.keys
        CACHE_POOL.with do |cache|
          cache.del(keys) if keys.present?
        end
      else
        raise BadRequest.new('Invalid Strategy')
      end
    end

    #
    # Get all keys
    #
    def self.keys(key_postfix = '')
      CACHE_POOL.with do |cache|
        cache.keys("#{key_prefix}#{key_postfix}*")
      end
    end

    #
    # Returns prefixed key
    #
    def self.prefixed_key(key)
      "#{key_prefix}#{key}"
    end

    #
    # Return key prefix
    #
    def self.key_prefix
      self::KEY_PREFIX.present? ? "#{self::KEY_PREFIX}-" : ''
    end

    #
    # Return options for redis
    #
    def self.redis_options(options)
      options[:ex] = options.delete(:expire_in) if options.key? :expire_in
      options
    end
  end
end
