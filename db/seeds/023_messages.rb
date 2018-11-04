puts 'Starting Messages'

users = User.all

users.each do |user|
  Message.create!(
    sender: user,
    recipient: users.reject { |usr| usr.id == user.id }.sample,
    content: Faker::Lorem.sentence,
    status: Message.statuses.keys.sample
  )
end

puts 'Completed Messages'
