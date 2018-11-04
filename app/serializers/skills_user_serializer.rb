class SkillsUserSerializer < ApplicationSerializer
  attributes :id, :user_id, :skill_id, :level

  has_one :skill
  has_one :user

  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :user_id, :skill_id, :level]
  end
end
