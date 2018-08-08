module Api::Admin
  class AuthController < BaseController
    def authenticate_user!
      # Skipping auth for internal api
      true
    end
  end
end
