class PaymentTransactionSerializer < ApplicationSerializer
  attributes :id, :order_id, :user_id, :gateway, :gateway_reference_number,
             :reference_number, :transaction_charges,
             :commission_charges, :currency_conversion_charges, :other_charges,
             :amount, :mode, :currency, :transaction_type, :status,
             :invoice_number, :created_at, :updated_at

  has_one :order
  has_one :user

  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :order_id, :user_id, :gateway, :gateway_reference_number,
     :reference_number, :transaction_charges,
     :commission_charges, :currency_conversion_charges, :other_charges,
     :amount, :mode, :currency, :transaction_type, :status,
     :invoice_number, :created_at, :updated_at]
  end
end
