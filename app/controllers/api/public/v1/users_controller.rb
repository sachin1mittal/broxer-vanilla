module Api::Public::V1
  class UsersController < ::BaseController

    def show
      render_serializer scope: user
    end

    private

    def user
      @user ||= User.find(params[:id])
    end

    def valid_show?
      param! :id, Integer, required: true, blank: false
    end
  end
end
