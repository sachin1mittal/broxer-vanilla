class AuthController < BaseController
  before_action :authorize_user!

  def authorize_user!
  	true
  end
end
