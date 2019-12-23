module Api::Public::V1
  class JobsController < ::BaseController
    skip_before_action :valid_action?, only: :show

    def index
      api_render json: { message: 'Public JobsController Index' }
    end

    def show
      render_serializer scope: job
    end

    private

    def job
      @job ||= Job.find(params[:id])
    end

    def valid_index?

    end
  end
end
