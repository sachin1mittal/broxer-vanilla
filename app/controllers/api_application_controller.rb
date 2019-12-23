class ApiApplicationController < ActionController::API
  include Concerns::Errors
  include Concerns::ErrorHandlers
  include Concerns::Cacheable
  include Concerns::ParamValidator
  include Concerns::ActionValidator

  before_action :set_paper_trail_whodunnit

  #
  # Add extra info to lograge payload
  #
  def append_info_to_payload(payload)
    super
    payload[:request] = request
    payload[:response] = response if Settings.LOGRAGE.ENABLE_RESPONSE
  end

  def health
    render json: {}
  end

  private

  def valid_health?
  end
end
