puts 'Starting Favourites'

all_jobs_and_users = [User.all, Job.all].flatten
FavouriteCollection.all.each do |collection|
  (1..5).to_a.sample.times do
    Favourite.create!(
      collection: collection,
      favourable: all_jobs_and_users.sample,
      status: [:active, :inactive].sample
    )
  end
end

puts 'Completed Favourites'
