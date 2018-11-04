class SessionsController < Devise::SessionsController
  def create
    token = AuthModule::UserManager.find_or_create(params)
    api_render json: { token: token }
  end

  private

  def valid_create?
    param! :provider, String, required: true, blank: false, in: User.providers.keys

    if params[:provider] == 'email'
      valid_create_by_email?
    else
      valid_create_by_social_platform?
    end
  end

  def valid_create_by_email?
    param! :email, String, required: true, transform: :strip, blank: false
    param! :password, String, required: true, blank: false
  end

  def valid_create_by_social_platform?
    param! :oauth_token, String, required: true, blank: false
  end
end
