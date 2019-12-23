module PublicRoutes
  def self.extended(router)
    router.instance_eval do
      post '/auth/:provider/callback', to: 'sessions#login_with_oauth'

      namespace 'api', module: 'api/public', as: :public do
        namespace :v1 do
          resources :categories, only: :index
          resources :jobs, only: [:show, :index]
          resources :users, only: :show
          resources :home, only: :index
          resources :collections, only: :index
        end
      end
    end
  end
end
