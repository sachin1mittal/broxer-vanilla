puts 'Starting Jobs'

all_categories = Category.where.not(parent_id: nil)

User.all.each do |user|
  10.times do
    Job.create!(
      category: all_categories.sample,
      user: user,
      title: Faker::Lorem.sentence,
      message_for_client: Faker::Lorem.paragraph,
      description: Faker::Lorem.sentence,
      status: [:draft, :posted, :inactive].sample,
      admin_status: [:approved, :disapproved].sample,
      order_limit: [50..1000].to_a.sample,
      banner: File.open('/Users/sachinmittal/Desktop/a.jpg', 'rb'),
      faqs: [{
        question:  Faker::Lorem.question,
        answer:  Faker::Lorem.sentence
      },
      {
        question:  Faker::Lorem.question,
        answer:  Faker::Lorem.sentence
      }]
    )
  end
end

puts 'Completed Jobs'
