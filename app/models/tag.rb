class Tag < ApplicationRecord
  has_many :tag_links
  has_many :jobs, through: :tag_links, source: :taggable, source_type: 'Job'
  has_many :users, through: :tag_links, source: :taggable, source_type: 'User'

  validates :name, presence: :true, uniqueness: :true
end
