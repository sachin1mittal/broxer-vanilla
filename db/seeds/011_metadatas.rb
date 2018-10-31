puts 'Starting Metadatas'

Category.where.not(parent_id: nil).each do |category|
  2.times do
    Metadata.create!(
      category: category,
      context: Faker::Lorem.words(3).join(' '),
      question: [Faker::Lorem.question, nil].sample,
      allowed_values: (1..[10, 25, 50, 75, 100].sample).to_a,
      allowed_values_count: (1..5).to_a.sample
    )
  end

  2.times do
    random_count = (1..10).to_a.sample
    Metadata.create!(
      category: category,
      context: Faker::Lorem.words(3).join(' '),
      question: [Faker::Lorem.question, nil].sample,
      allowed_values: Faker::Lorem.words(random_count),
      allowed_values_count: (1..10).to_a.sample
    )
  end

  2.times do
    Metadata.create!(
      category: category,
      context: Faker::Lorem.words(3).join(' '),
      question: [Faker::Lorem.question, nil].sample,
      allowed_values: [true, false],
      allowed_values_count: 1
    )
  end
end

puts 'Completed Metadatas'
