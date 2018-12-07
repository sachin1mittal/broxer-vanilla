Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_AUTHENTICATION_CLIENT_ID'], ENV['FACEBOOK_AUTHENTICATION_CLIENT_SECRET'], scope: 'email,user_link', provider_ignores_state: true
  provider :twitter, ENV['TWITTER_AUTHENTICATION_CLIENT_ID'], ENV['TWITTER_AUTHENTICATION_CLIENT_SECRET'], provider_ignores_state: true
  provider :linkedin, ENV['LINKEDIN_AUTHENTICATION_CLIENT_ID'], ENV['LINKEDIN_AUTHENTICATION_CLIENT_SECRET'], provider_ignores_state: true
  provider :google_oauth2, ENV['GOOGLE_AUTHENTICATION_CLIENT_ID'], ENV['GOOGLE_AUTHENTICATION_CLIENT_SECRET'], provider_ignores_state: true
 end

OmniAuth.config.on_failure = SessionsController.action(:oauth_failure)
