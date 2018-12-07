module Api::Admin::V1
  class ActionLogsController < ::Api::Admin::AuthController
  	skip_before_action :valid_action?, only: [:index]

    def index
      resources = ActionLog.includes(params[:include])
      render_serializer scope: resources
    end

    private

    def index_params
    end
  end
end
