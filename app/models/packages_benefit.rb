class PackagesBenefit < ApplicationRecord
  has_paper_trail

  belongs_to :benefit
  belongs_to :package
  validates :values, presence: true
end
