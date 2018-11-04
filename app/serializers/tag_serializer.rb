class TagSerializer < ApplicationSerializer
  attributes :id, :name

  has_many :tag_links
  has_many :jobs
  has_many :users

  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :name]
  end
end
