Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/health',     to: 'application#health'
  post '/auth/:provider/callback', to: 'sessions#login_with_oauth'

  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  extend SellersRoutes
  extend BuyersRoutes
  extend PublicRoutes

  ######## For Chats ########

  # namespace :api do
  #   namespace :v1 do
  #     resources :users, only: [:index, :create, :show] do
  #       resources :conversations, only: [:index, :show, :create] do
  #         resources :messages, only: [:create]
  #       end
  #     end
  #   end
  # end
  # root to: 'chat#index'

  # mount ActionCable.server => '/cable'

  ######## For Chats ########

end
