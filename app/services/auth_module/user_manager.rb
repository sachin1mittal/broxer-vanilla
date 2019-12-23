module AuthModule
  #
  # This class is responsible for managing users
  #
  # @author [sachinmittal]
  #
  class UserManager
    attr_accessor :user

    #
    # Initialize Method
    # @param user [User instance]
    #
    def initialize(user)
      self.user = user
    end

    def self.find_or_create_with_oauth(provider, params)
      # if params[:provider] == 'email'
      #   User.find_by_email_password!(
      #     email: params[:email],
      #     password: params[:password]
      #   )
      # else
      #   fetch_user_from_oauth_token(params[:provider], params[:oauth_token])
      # end

      # user.generate_jwt
    end

    # def self.create(params)

    # end

    # def update(params)

    # end
  end
end
