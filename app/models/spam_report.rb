class SpamReport < ApplicationRecord
  has_paper_trail

  belongs_to :reportable, polymorphic: true
  belongs_to :reporter, class_name: 'User'

  enum status: {
    pending: 'pending',
    accepted: 'accepted',
    rejected: 'rejected'
  }

  before_save :init

  def init
    self.status ||= :pending
  end
end
