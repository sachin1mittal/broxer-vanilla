module Api::Buyers::V1
  class UsersController < ::Api::Buyers::AuthController
    skip_before_action :valid_action?, only: [:show]

    def update
      current_user.update_attributes!(update_user_params)
      render_serializer scope: current_user
    end

    def show
      render_serializer scope: user
    end

    private

    def update_user_params
      params.require(:users).permit()
    end

    def user
      @user ||= User.find(params[:id])
    end
  end
end
