puts 'Starting Skills'

100.times do
  Skill.create(name: Faker::Hacker.ingverb)
end

puts 'Completed Skills'
