puts 'Starting Orders'

packages = Package.includes(:job)
users = User.all

users.each do |user|
  package = packages.sample
  job = package.job
  quantity = (1..5).to_a.sample
  other_user = users.reject { |us| us.id == user.id }.sample
  PackageOrder.create!(
    buyer: user,
    seller: other_user,
    package: package,
    quantity: quantity,
    amount: package.price * quantity,
    payment_status: Order.payment_statuses.keys.sample,
    progress_status: Order.progress_statuses.keys.sample,
    dispute_status: Order.dispute_statuses.keys.sample,
    expected_completion_date: (5..10).to_a.sample.days.from_now.to_date,
    expected_delivery_time: package.delivery_time,
    description: Faker::Lorem.sentence,
    job_requirements: job.requirements.map do |req|
      case req['type']
      when 'text'
        { requirement_id: req['id'], answer: Faker::Lorem.sentence }
      when 'mcq'
        { requirement_id: req['id'], answers: ['0', '1', '2'] - [['0', '1', '2'].sample] }
      when 'file'
        { requirement_id: req['id'], document_id: (1..100).to_a.sample }
      end
    end
  )
end

puts 'Completed Orders'
