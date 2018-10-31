class Favourite < ApplicationRecord
  belongs_to :favourable, polymorphic: true
  belongs_to :collection, class_name: 'FavouriteCollection'

  enum status: {
    active: 'active',
    inactive: 'inactive'
  }

  validates :status, presence: true
end
