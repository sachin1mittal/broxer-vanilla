module Concerns::Cacheable
  extend ::ActiveSupport::Concern

  module ClassMethods
    #
    # Set hooks for caching response
    # @param provider = Caches::Base [Caches::Base/Proc] Cache Provider Class or Proc
    # @param attributes = {} [Hash] Hash of arguments
    #
    def cache_response(provider = Caches::Base, arguments = {})
      # Set hook options
      hook_options = arguments.except(:expire_in)
      # Set cache options
      cache_options = arguments.slice(:expire_in)
      # Init cache options
      cache_options[:expire_in] ||= 15.minutes

      # Set around action to return response from cache
      around_action hook_options do |_, block|
        raise InvalidCache.new('Can only cache GET request'.freeze) unless request.get?

        cache = resolved_cache(provider)

        cached_data = cached_response(cache)
        # Check cached response
        if cached_data.present?
          # Send the cached response
          render json: cached_data
          next
        end

        block.call

        # Cache the response
        set_cache(cache, cache_options)
      end
    end
  end

  #
  # Set current response as cache
  #
  def set_cache(cache, options = {})
    cache.set(cache_key, response.body, options)
  end

  #
  # Returns the cached response
  #
  def cached_response(cache)
    @cached_response ||= cache.get(cache_key) rescue nil
  end

  #
  # Defines the cache key
  #
  # @return [String]
  def cache_key
    return @cache_key if @cache_key.present?
    sorted_params = request.query_parameters.sort_by {|k, v| k.to_s}
    key_path = "#{request.path}?#{URI.encode_www_form(sorted_params)}"
    @cache_key = Digest::MD5.hexdigest key_path
  end

  #
  # Return cache provider after resolving
  #
  def resolved_cache(provider)
    case provider
    when Proc
      provider.call(self)
    else
      provider
    end
  end
end
