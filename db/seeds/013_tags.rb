puts 'Starting Tags'

500.times do
  Tag.create(name: Faker::Hacker.adjective)
end

puts 'Completed Tags'
