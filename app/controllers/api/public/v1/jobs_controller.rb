module Api::Public::V1
  class JobsController < ::Api::Public::BaseController
    skip_before_action :valid_action?

    def index
    end

    def show
      render_serializer scope: job
    end

    private

    def job
      @job ||= Job.find(params[:id])
    end
  end
end
