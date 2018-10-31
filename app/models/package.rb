class Package < ApplicationRecord
  has_paper_trail

  has_many :orders, class_name: 'PackageOrder'
  has_many :packages_benefits
  belongs_to :job

  enum package_type: {
    basic: 'basic',
    standard: 'standard',
    premium: 'premium'
  }

  validates_presence_of :title, :package_type, :description, :delivery_time, :price
end
