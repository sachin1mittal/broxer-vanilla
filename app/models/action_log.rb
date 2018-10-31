class ActionLog < ApplicationRecord
  belongs_to :performer, class_name: 'User', optional: true
  belongs_to :actionable, polymorphic: true

  validates :action, presence: true
end
