class AuthController < BaseController
  before_action :authenticate_user!

  def authenticate_user!
  	true
    # current_user.present?
  end
end
