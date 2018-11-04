class CategorySerializer < ApplicationSerializer
  attributes :id, :name, :parent_id, :description, :banner, :logo

  has_one :parent_category
  has_many :child_categories
  has_many :benefits
  has_many :jobs
  has_many :metadatas
  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :name, :parent_id, :description, :banner, :logo]
  end
end
