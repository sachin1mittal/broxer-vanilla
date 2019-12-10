module DevelopersRoutes
  def self.extended(router)
    router.instance_eval do
      get '/health',     to: 'application#health'

      require 'sidekiq/web'
      require 'sidekiq/cron/web'
      mount Sidekiq::Web => '/sidekiq'
    end
  end
end
