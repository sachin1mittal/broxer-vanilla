puts 'Starting Categories'

10.times do
  parent_cat1 = Category.create!(
    name: Faker::Hacker.ingverb + SecureRandom.hex[0..2],
    logo: File.open('/Users/sachin/Desktop/a.jpg', 'rb'),
    description: Faker::Lorem.sentence,
    banner: File.open('/Users/sachin/Desktop/a.jpg', 'rb')
  )

  10.times do |count|
    Category.create!(
      parent_id: parent_cat1.id,
      name: Faker::Hacker.ingverb + SecureRandom.hex[0..2],
      description: Faker::Lorem.sentence,
      logo: File.open('/Users/sachin/Desktop/a.jpg', 'rb'),
      banner: File.open('/Users/sachin/Desktop/a.jpg', 'rb')
    )
  end
end

puts 'Completed Categories'
