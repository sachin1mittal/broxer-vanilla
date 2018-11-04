class MetadataSerializer < ApplicationSerializer
  attributes :id, :category_id, :context, :question, :allowed_values,
             :allowed_values_count, :created_at, :updated_at

  has_one :category
  has_many :jobs_metadatas

  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    %i[id material_request_id sku_id quantity status schedule_date created_at
       updated_at]
  end
end
