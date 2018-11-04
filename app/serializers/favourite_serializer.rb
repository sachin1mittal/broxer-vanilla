class FavouriteSerializer < ApplicationSerializer
  attributes :id, :status, :collection_id, :favourable_id, :favourable_type,
             :created_at, :updated_at

  has_one :favourable
  has_one :collection
  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :status, :collection_id, :favourable_id, :favourable_type,
     :created_at, :updated_at]
  end
end
