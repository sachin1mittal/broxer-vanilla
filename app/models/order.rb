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

  enum status: {
    pending: 'pending',
    placed: 'placed',
    active: 'active',
    rejected: 'rejected',
    submitted: 'submitted',
    submission_rejected: 'submission_rejected',
    delivered: 'delivered'
  }

  validates :amount, numericality: { only_integer: true, greater_than: 0 }
  validates_presence_of :reference_number, :amount, :status, :payment_status

  before_validation :init

  private

  def init
    self.reference_number ||= assign_reference_number
  end

  def assign_reference_number
    assigned_reference_numbers = self.class.pluck(:reference_number)
    begin
      current_reference_number = SecureRandom.hex(3).upcase.prepend('BRXR-')
    end while assigned_reference_numbers.include?(current_reference_number)
  end
end
