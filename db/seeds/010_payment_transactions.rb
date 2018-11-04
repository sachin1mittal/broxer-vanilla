puts 'Starting Payment Transactions'

Order.includes(:buyer).all.each do |order|
  transaction_charges = (1..5).step(0.1).to_a.sample.round(1)
  commission_charges = (1..5).step(0.1).to_a.sample.round(1)
  currency_conversion_charges = (1..5).step(0.1).to_a.sample.round(1)
  other_charges = (1..5).step(0.1).to_a.sample.round(1)
  total_amount = transaction_charges + commission_charges +
    currency_conversion_charges + other_charges + order.amount

  PaymentTransaction.create!(
    order: order,
    user: order.buyer,
    gateway: PaymentTransaction.gateways.keys.sample,
    gateway_reference_number: SecureRandom.hex(5),
    transaction_charges: transaction_charges,
    commission_charges: commission_charges,
    currency_conversion_charges: currency_conversion_charges,
    other_charges: other_charges,
    amount: total_amount,
    mode: PaymentTransaction.modes.keys.sample,
    currency: PaymentTransaction.currencies.keys.sample,
    transaction_type: PaymentTransaction.transaction_types.keys.sample,
    status: PaymentTransaction.statuses.keys.sample,
    invoice_number: SecureRandom.hex(5)
  )
end

puts 'Completed Payment Transactions'
