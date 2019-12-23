module Api::Public::V1
  class CollectionsController < ::BaseController

    def index
      api_render json: data_collections
    end

    private

    def data_collections
      params[:fields].inject({}) do |result, resource|
        result.merge!(resource => send(resource)) if params[:fields]&.include?(resource)
        result
      end
    end

    def categories
      @categories ||= Category.limit(params[:categories_limit]).offset(params[:categories_offset])
    end

    def skills
      @skills ||= Skill.limit(params[:skills_limit]).offset(params[:skills_offset])
    end

    def tags
      @tags ||= Tag.limit(params[:tags_limit]).offset(params[:tags_offset])
    end

    def countries
      @countries ||= Country.limit(params[:countries_limit]).offset(params[:countries_offset])
    end

    def valid_index?
      if !params[:fields].is_a?(Array) || (params[:fields] - resources).present?
        raise RailsParam::Param::InvalidParameterError
      end

      param! :categories_limit, Integer, required: false, blank: false
      param! :countries_limit, Integer, required: false, blank: false
      param! :tags_limit, Integer, required: false, blank: false
      param! :skills_limit, Integer, required: false, blank: false
      param! :categories_offset, Integer, required: false, blank: false
      param! :countries_offset, Integer, required: false, blank: false
      param! :tags_offset, Integer, required: false, blank: false
      param! :skills_offset, Integer, required: false, blank: false
    end

    def resources
      [:categories, :tags, :skills, :countries]
    end
  end
end
