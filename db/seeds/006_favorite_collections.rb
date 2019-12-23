puts 'Starting Favourite Collections'

User.all.each do |user|
  2.times do
    FavouriteCollection.create!(
      name: Faker::Name.name,
      user: user
    )
  end
end

puts 'Completed Favourite Collections'
