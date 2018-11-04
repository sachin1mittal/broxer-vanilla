module Api::Public::V1
  class UsersController < ::Api::Public::AuthController
    skip_before_action :valid_action?, only: [:show]

    def create

    end

    def update
      current_user.update_attributes!(update_user_params)
      render_serializer scope: current_user
    end

    def show
      render_serializer scope: user
    end

    def public_show

    end

    private

    def update_user_params
      params.require(:users).permit()
    end

    def create_user_params
      params.require(:users).permit()
    end

    def valid_create?

    end

    def valid_update?

    end

    def user
      @user ||= User.find(params[:id])
    end
  end
end
