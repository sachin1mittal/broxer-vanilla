class TagLinkSerializer < ApplicationSerializer
  attributes :id, :tag_id, :taggable_id, :taggable_type

  has_one :tag
  has_one :taggable

  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :tag_id, :taggable_id, :taggable_type]
  end
end
