class BenefitSerializer < ApplicationSerializer
  attributes :id, :name, :allowed_values, :category_id, :allowed_values_count,
             :category, :packages_benefits

  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :name, :allowed_values, :category_id, :allowed_values_count]
  end
end
