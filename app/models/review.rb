class Review < ApplicationRecord
  has_paper_trail

  belongs_to :reviewable, polymorphic: true
  belongs_to :parent, class_name: 'Review', optional: true
  belongs_to :reviewer, class_name: 'User'
  has_many :children, class_name: 'Review', foreign_key: 'parent_id'
end
