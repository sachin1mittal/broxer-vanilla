require_relative './constraints/seller_constraint'

module SellersRoutes
  def self.extended(router)
    router.instance_eval do
      namespace 'api', module: 'api/sellers', as: :sellers, constraints: Constraints::SellerConstraint.new do
        namespace :v1 do

        end
      end
    end
  end
end
