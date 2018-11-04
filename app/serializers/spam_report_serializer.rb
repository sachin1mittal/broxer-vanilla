class SpamReportSerializer < ApplicationSerializer
  attributes :id, :reportable_id, :reportable_type, :reporter_id, :status,
             :comment, :created_at, :updated_at

  has_one :reportable
  has_one :reporter

  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :reportable_id, :reportable_type, :reporter_id, :status,
     :comment, :created_at, :updated_at]
  end
end
