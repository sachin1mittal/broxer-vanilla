require_relative './constraints/buyer_constraint'

module BuyersRoutes
  def self.extended(router)
    router.instance_eval do
      namespace 'api', module: 'api/buyers', as: :buyers, constraints: BuyerConstraint.new do
        namespace :v1 do
        end
      end
    end
  end
end
