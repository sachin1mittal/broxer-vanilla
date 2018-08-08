module AdminRoutes
  def self.extended(router)
    router.instance_eval do
      namespace 'api/admin' do
      end
    end
  end
end
