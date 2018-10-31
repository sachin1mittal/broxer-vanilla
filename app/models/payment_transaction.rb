class PaymentTransaction < ApplicationRecord
  has_paper_trail

  belongs_to :order
  belongs_to :user
  has_many :action_logs, as: :actionable

  enum gateway: {
    razorpay: 'razorpay',
    payu: 'payu',
    paypal: 'paypal'
  }

  enum mode: {
    credit_debit_card: 'credit_debit_card',
    net_banking: 'net_banking',
    e_wallet: 'e_wallet'
  }

  enum currency: {
    INR: 'INR',
    USD: 'USD',
    GBP: 'GBP',
    PKR: 'PKR',
    BDT: 'BDT'
  }

  enum transaction_type: {
    payment: 'payment',
    refund: 'refund'
  }

  enum status: {
    pending: 'pending',
    success: 'success',
    failure: 'failure'
  }

  validates_presence_of :gateway, :gateway_reference_number, :reference_number,
    :order_amount, :amount, :mode, :currency, :transaction_type, :status, :invoice_number

  validates :order_amount, numericality: { integer: true, greater_than: 0 }
  validates_numericality_of :transaction_charges, :commission_charges, :currency_conversion_charges,
    :other_charges, :amount, numericality: { greater_than: 0, allow_nil: true }
end
