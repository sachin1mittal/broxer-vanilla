module PublicRoutes
  def self.extended(router)
    router.instance_eval do
      post '/auth/:provider/callback', to: 'sessions#login_with_oauth'

      namespace 'api', module: 'api/public', as: :public do
        namespace :v1 do
          resources :categories, only: [:show]
          resources :jobs, only: [:show, :index]
          resources :users, only: [:show]
          resources :home, only: [:index] do
            collection do
              get :privacy_policy
              get :about_us
              get :contact_us
              get :terms_and_conditions
            end
          end
        end
      end
    end
  end
end
