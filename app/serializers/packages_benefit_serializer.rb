class PackagesBenefitSerializer < ApplicationSerializer
  attributes :id, :benefit_id, :package_id, :values, :created_at, :updated_at

  has_one :benefit
  has_one :package

  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :benefit_id, :package_id, :values, :created_at, :updated_at]
  end
end
