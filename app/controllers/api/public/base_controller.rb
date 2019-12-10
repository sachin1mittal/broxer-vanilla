module Api::Public
  class BaseController < ::BaseController
    skip_before_action :authenticate_user!
  end
end
