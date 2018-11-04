class FavouriteCollectionSerializer < ApplicationSerializer
  attributes :id, :name, :user_id, :created_at, :updated_at

  has_many :favourites
  has_one :user
  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :name, :user_id, :created_at, :updated_at]
  end
end
