class Skill < ApplicationRecord
  has_many :skills_users
  has_many :users, through: :skills_users

  validates :name, presence: :true, uniqueness: :true
end
