module PublicRoutes
  def self.extended(router)
    router.instance_eval do
      namespace 'api/public' do
      end
    end
  end
end
