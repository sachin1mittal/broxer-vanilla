class SkillSerializer < ApplicationSerializer
  attributes :id, :name

  has_many :skills_users
  has_many :users

  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :name]
  end
end
