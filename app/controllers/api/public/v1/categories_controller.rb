module Api::Public::V1
  class CategoriesController < ::BaseController
    skip_before_action :valid_action?

    def index
      api_render json: { message: 'Public CategoriesController Index' }
    end
  end
end
