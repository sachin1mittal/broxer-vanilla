puts 'Starting Orders'

packages = Package.all
users = User.all

users.each do |user|
  package = packages.sample
  quantity = (1..5).to_a.sample
  other_user = users.reject { |us| us.id == user.id }.sample
  PackageOrder.create!(
    buyer: user,
    seller: other_user,
    package: package,
    quantity: quantity,
    amount: package.price * quantity,
    status: [:pending, :placed, :in_progress, :rejected, :submitted, :submission_rejected, :delivered].sample,
    payment_status: [:unpaid, :paid, :refund_requested, :refunded].sample,
    expected_completion_date: (5..10).to_a.sample.days.from_now.to_date,
    reference_number: (100000..999999).to_a.sample
  )
end

puts 'Completed Orders'
