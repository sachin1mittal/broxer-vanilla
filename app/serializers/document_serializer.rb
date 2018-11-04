class DocumentSerializer < ApplicationSerializer
  attributes :id, :fyle, :documentable_id, :documentable_type, :created_at, :updated_at

  has_one :documentable
  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :fyle, :documentable_id, :documentable_type, :created_at, :updated_at]
  end
end
