class ReviewSerializer < ApplicationSerializer
  attributes :id, :reviewable_id, :reviewable_type, :reviewer_id, :act, :comment,
             :parent_id, :rating, :updated_at, :created_at

  has_one :reviewable
  has_one :reviewer
  has_one :parent
  has_many :children

  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :reviewable_id, :reviewable_type, :reviewer_id, :act, :comment,
     :parent_id, :rating, :updated_at, :created_at]
  end
end
