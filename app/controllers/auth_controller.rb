class AuthController < BaseController
  include Concerns::ThreadUserable

  before_action :authenticate_user!

  def current_user
    return unless signed_in?
    @current_user ||= User.find(@current_user_id)
  rescue ActiveRecord::RecordNotFound
    raise ::Unauthorized
  end

  def signed_in?
    @current_user_id.present?
  end

  def authenticate_user!
    # token = request.headers['Authorization']
    # return unless token.present?
    # jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first
    # @current_user_id = jwt_payload['id']
    @current_user_id = 100
  rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
    raise ::Unauthorized
  end
end
