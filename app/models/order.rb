class Order < ApplicationRecord
  has_paper_trail

  belongs_to :buyer, class_name: 'User'
  belongs_to :seller, class_name: 'User'
  belongs_to :package
  has_many :payment_transactions
  has_many :action_logs, as: :actionable

  enum payment_status: {
    unpaid: 'unpaid',
    paid: 'paid',
    refund_requested: 'refund_requested',
    refunded: 'refunded'
  }

  enum progress_status: {
    active: 'active',
    cancelled: 'cancelled',
    completed: 'completed',
    delivered: 'delivered',
    revision: 'revision'
  }

  enum dispute_status: {
    resolved: 'resolved',
    missing_details: 'missing_details',
    disputed: 'disputed'
  }

  validates :amount, numericality: { only_integer: true, greater_than: 0 }
  validates_presence_of :reference_number, :amount, :progress_status, :payment_status

  before_validation :init

  private

  def init
    self.reference_number ||= assign_reference_number
    self.payment_status ||= :unpaid
    self.progress_status ||= :active
    self.progress_status ||= :resolved
  end

  def assign_reference_number
    begin
      current_reference_number = SecureRandom.hex(5).upcase.prepend('BRXR-')
    end while self.class.where(reference_number: current_reference_number).exists?

    current_reference_number
  end
end
