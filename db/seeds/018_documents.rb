puts 'Starting Documents'

all_jobs = Job.all

1000.times do
  Document.create!(documentable: all_jobs.sample, fyle: File.open('/Users/sachinmittal/Desktop/a.jpg', 'rb'))
end

puts 'Completed Documents'
