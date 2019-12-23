module Api::Sellers
  class AuthController < BaseController
    before_action :authorize_user!

    def authorize_user!
      true
      #current_user.seller?
    end
  end
end
