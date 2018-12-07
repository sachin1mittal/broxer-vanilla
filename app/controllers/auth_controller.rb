class AuthController < BaseController
  before_action :authorize_user!

  def authorize_user!
  	true
    # AuthModule::Permissions.new(
    #   user: current_user,
    #   controller: params[:controller],
    #   action: params[:action]
    # ).authorize!
  end
end
