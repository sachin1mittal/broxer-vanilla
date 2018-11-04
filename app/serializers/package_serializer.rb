class PackageSerializer < ApplicationSerializer
  attributes :id, :job_id, :title, :package_type, :description,
             :delivery_time, :revisions, :price, :extras, :created_at, :updated_at

  has_many :orders
  has_many :packages_benefits
  has_one :job

  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :job_id, :title, :package_type, :description,
     :delivery_time, :revisions, :price, :extras, :created_at, :updated_at]
  end
end
