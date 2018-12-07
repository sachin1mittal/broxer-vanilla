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
      banner: File.open('/Users/sachin/Desktop/a.jpg', 'rb'),
      faqs: [{
        question:  Faker::Lorem.question,
        answer:  Faker::Lorem.sentence
      },
      {
        question:  Faker::Lorem.question,
        answer:  Faker::Lorem.sentence
      }],
      requirements: [{
        id: SecureRandom.uuid,
        type:  :text,
        question:  Faker::Lorem.question,
        mandatory: [true, false].sample
      },
      {
        id: SecureRandom.uuid,
        type:  :mcq,
        question:  Faker::Lorem.question,
        answers: {}.tap { |hash| 3.times { |index| hash[index.to_s] = Faker::Lorem.sentence } },
        multiple: [true, false].sample,
        mandatory: [true, false].sample
      },
      {
        id: SecureRandom.uuid,
        type:  :file,
        filetype: :png,
        question:  Faker::Lorem.question,
        mandatory: [true, false].sample
      }]
    )
  end
end

puts 'Completed Jobs'
