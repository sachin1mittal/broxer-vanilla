class CountrySerializer < ApplicationSerializer
  attributes :id, :name, :phone_code

  has_many :users
  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :name, :phone_code]
  end
end
