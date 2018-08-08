class FavouriteCollection < ApplicationRecord
  has_many :favourites, foreign_key: 'collection_id'
  belongs_to :user

  validates :name, presence: true
end
