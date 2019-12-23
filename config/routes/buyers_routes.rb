require_relative './constraints/buyer_constraint'

module BuyersRoutes
  def self.extended(router)
    router.instance_eval do
      namespace 'api', module: 'api/buyers', as: :buyers, constraints: Constraints::BuyerConstraint.new do
        namespace :v1 do
          resources :favourite_collections, except: [:new, :edit]
        end
      end
    end
  end
end
