class CategorySerializer < ApplicationSerializer
  attributes :id, :name, :parent_id, :description, :banner, :logo,
             :parent_category, :child_categories, :benefits, :jobs, :metadatas

  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :name, :parent_id, :description, :banner, :logo]
  end
end
