module PublicRoutes
  def self.extended(router)
    router.instance_eval do
      namespace 'api', module: 'api/public', as: :public do
        namespace :v1 do
        end
      end
    end
  end
end
