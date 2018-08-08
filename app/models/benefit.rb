class Benefit < ApplicationRecord
  belongs_to :category
  has_many :packages_benefits

  validates :name, presence: true, uniqueness: { scope: :category_id }
end
