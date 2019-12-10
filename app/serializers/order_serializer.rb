class OrderSerializer < ApplicationSerializer
  attributes :id, :buyer_id, :seller_id, :reference_number, :description,
             :package, :quantity, :amount, :expected_completion_date,
             :expected_delivery_time, :payment_status, :created_at, :updated_at

  has_one :buyer
  has_one :seller
  has_one :package
  has_many :payment_transactions
  #
  # Default attributes for serializer
  #
  # @return [Array] Array of symbolize attributes
  def self.default_attributes
    [:id, :buyer_id, :seller_id, :reference_number, :description,
     :package, :quantity, :amount, :expected_completion_date,
     :expected_delivery_time, :payment_status, :created_at, :updated_at]
  end
end
