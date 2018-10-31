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
    gateway: [:razorpay, :payu, :paypal].sample,
    gateway_reference_number: SecureRandom.hex(5),
    reference_number: SecureRandom.hex(5),
    order_amount: order.amount,
    transaction_charges: transaction_charges,
    commission_charges: commission_charges,
    currency_conversion_charges: currency_conversion_charges,
    other_charges: other_charges,
    amount: total_amount,
    mode: [:credit_debit_card, :net_banking, :e_wallet].sample,
    currency: [:INR, :USD, :GBP, :PKR, :PKR, :BDT].sample,
    transaction_type: [:payment, :refund].sample,
    status: [:pending, :success, :failure].sample,
    invoice_number: SecureRandom.hex(5)
  )
end

puts 'Completed Payment Transactions'
