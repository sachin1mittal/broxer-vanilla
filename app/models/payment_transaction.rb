class PaymentTransaction < ApplicationRecord
  has_paper_trail

  belongs_to :order, optional: true
  belongs_to :user

  enum gateway: {
    razorpay: 'razorpay',
    payu: 'payu',
    paypal: 'paypal'
  }

  enum mode: {
    credit_debit_card: 'credit_debit_card',
    net_banking: 'net_banking',
    e_wallet: 'e_wallet',
    broxer_wallet: 'broxer_wallet'
  }

  enum currency: {
    INR: 'INR',
    USD: 'USD',
    GBP: 'GBP',
    PKR: 'PKR',
    BDT: 'BDT'
  }

  enum transaction_type: {
    credit: 'credit',
    debit: 'debit'
  }

  enum status: {
    pending: 'pending',
    success: 'success',
    failure: 'failure'
  }

  validates_presence_of :gateway, :gateway_reference_number, :reference_number,
    :amount, :mode, :currency, :transaction_type, :status, :invoice_number

  validates_numericality_of :transaction_charges, :commission_charges, :currency_conversion_charges,
    :other_charges, :amount, numericality: { greater_than: 0, allow_nil: true }

  before_validation :init

  private

  def init
    self.reference_number ||= assign_reference_number
    self.status ||= :pending
  end

  def assign_reference_number
    begin
      current_reference_number = SecureRandom.hex(5).upcase.prepend('BRXR-')
    end while self.class.where(reference_number: current_reference_number).exists?

    current_reference_number
  end
end
