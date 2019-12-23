module Api::Public::V1
  class HomeController < ::BaseController
    skip_before_action :valid_action?

    def index
      api_render json: { message: 'Public HomeController Index' }
    end
  end
end
