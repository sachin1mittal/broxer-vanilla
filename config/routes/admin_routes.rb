module AdminRoutes
  def self.extended(router)
    router.instance_eval do
      namespace 'api', module: 'api/admin', as: :admin do
        namespace :v1 do
          resources :action_logs, only: :index
        end
      end
    end
  end
end
