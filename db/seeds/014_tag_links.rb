puts 'Starting Tag Links'

all_jobs = Job.all
all_users = User.all
all_tags = Tag.all

1000.times do
  TagLink.create!(tag: all_tags.sample, taggable: all_jobs.sample)
  TagLink.create!(tag: all_tags.sample, taggable: all_users.sample)
end

puts 'Completed Tag Links'
