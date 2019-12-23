class BaseController < ApiApplicationController
  prepend_before_action :prepare_params
  before_action :valid_pagination_params?


  def valid_pagination_params?
    param! :page, Integer, default: 1
    param! :per_page, Integer, default: Settings.CONSTANTS.PAGINATION.DEFAULT_PER_PAGE
  end

  #
  # Preprocess params
  #
  def prepare_params
    param! :fields, String, default: '', transform: -> (param) { param.split(',').map(&:to_sym) }
    param! :include, String, default: '', transform: -> (param) { param.split(',').map(&:to_sym) }
    param! :query, String, blank: false, transform: -> (query) { query.strip }
  end

  #
  # render custom data
  #
  def api_render(json:, meta: nil, status: :ok, root: nil, is_success: true, fields: [])
    if is_success
      data = if root.blank?
               { data: json }
             else
               { data: { root => json } }
             end
    else
      data = { errors: json }
    end
    data = data.merge({ meta: meta }) unless meta.blank?
    data = data.merge({ is_success: is_success, status_code: Rack::Utils::SYMBOL_TO_STATUS_CODE[status] })
    render json: data, status: status, fields: fields
  end

  #
  # Perform render operation with serializers
  # @param scope: ActiveRecord Scope
  # @param meta: {} [Hash] Meta data
  # @param query: params [Hash] Hash for performing filtering, sorting, pagination
  # @param pagination: true [Boolean] Flag to disable pagination
  # @param pagination_meta: true [Boolean] Flag to disable pagination meta
  # @param sorting: false [Boolean] Flag to enable sorting
  # @param after_serialize: nil [Proc] Block to process after serialization
  #
  def render_serializer(scope:, meta: {}, query: params, pagination: true, pagination_meta: true, sorting: false, after_serialize: nil)
    pre_processor = Rendor::PreProcessor.new(
        scope: scope,
        meta: meta,
        query: query,
        pagination: pagination,
        pagination_meta: pagination_meta,
        sorting: sorting,
        after_serialize: after_serialize
      )
    pre_processor.serialized
    api_render json: pre_processor.json, meta: pre_processor.meta
  end
end
