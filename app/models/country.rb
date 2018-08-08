class Country < ApplicationRecord
  has_many :users

  validates_presence_of :name, :phone_code
end
