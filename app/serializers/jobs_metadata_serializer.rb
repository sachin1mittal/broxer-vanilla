class JobsMetadataSerializer < ApplicationSerializer
  attributes :id, :job_id, :metadata_id, :values, :created_at, :updated_at

  has_one :job
  has_one :metadata
  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :job_id, :metadata_id, :values, :created_at, :updated_at]
  end
end
