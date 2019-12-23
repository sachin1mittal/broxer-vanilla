puts 'Starting Benefits'

Category.where.not(parent_id: nil).each do |category|

  2.times do
    Benefit.create(
      category: category,
      name: Faker::Hacker.noun,
      allowed_values: (1..[10, 25, 50, 75, 100].sample).to_a,
      allowed_values_count: (1..5).to_a.sample
    )
  end

  2.times do
    Benefit.create(
      category: category,
      name: Faker::Hacker.noun,
      allowed_values: [
        Faker::Hacker.adjective,
        Faker::Hacker.adjective,
        Faker::Hacker.adjective,
        Faker::Hacker.adjective,
        Faker::Hacker.adjective
      ],
      allowed_values_count: (1..5).to_a.sample
    )
  end

  2.times do
    Benefit.create(
      category: category,
      name: Faker::Hacker.noun,
      allowed_values: ['true', 'false'],
      allowed_values_count: (1..5).to_a.sample
    )
  end

end

puts 'Completed Benefits'
