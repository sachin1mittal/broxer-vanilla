class SkillsUser < ApplicationRecord
  belongs_to :skill
  belongs_to :user

  enum level: {
    beginner: 'beginner',
    intermediate: 'intermediate',
    expert: 'expert'
  }

  validates :level, presence: true
end
