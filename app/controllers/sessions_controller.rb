class SessionsController < BaseController
  skip_before_action :authenticate_user!

  def login_with_oauth
    token = AuthModule::UserManager.find_or_create_with_oauth(params[:provider], omniauth_params)
    api_render json: { token: token }
  end

  def oauth_failure
    raise Unauthorized.new('Unauthorized User')
  end

  def login_with_email

  end

  def signup_with_email

  end

  private

  def valid_login_with_oauth?
    param! :provider, String, required: true, blank: false
  end

  def valid_login_with_email?
    param! :email, String, required: true, transform: :strip, blank: false
    param! :password, String, required: true, blank: false
  end

  def valid_signup_with_email?
    param! :email, String, required: true, transform: :strip, blank: false
    param! :password, String, required: true, blank: false
  end

  def omniauth_data
    request.env['omniauth.auth']
  end

  def omniauth_params
    omniauth_data = request.env['omniauth.auth']

    {
      name: omniauth_data.info.name,
      email: omniauth_data.info.email,
      provider: omniauth_data.provider,
      uid: omniauth_data.uid,
      authentication_token: omniauth_data.credentials.token,
      token_expires_at: omniauth_data.credentials.expires_at,
      profile_pic_from_url: omniauth_data.info.image,
      gplus_profile: omniauth_data.info.urls.try(:google),
      facebook_profile: omniauth_data.info.urls.try(:facebook),
      twitter_profile: omniauth_data.info.urls.try(:Twitter),
      linkedin_profile: omniauth_data.info.urls.try(:public_profile)
    }
  end
end
