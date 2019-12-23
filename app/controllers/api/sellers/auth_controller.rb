module Api::Sellers
  class AuthController < ::AuthController
    before_action :authorize_user!

    def authorize_user!
      current_user.seller?
    end
  end
end
