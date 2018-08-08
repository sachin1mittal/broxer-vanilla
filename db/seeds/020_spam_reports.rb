puts 'Starting Spam Reports'

SpamReport.create!(
  reporter: User.first,
  reportable: Job.last,
  comment: 'Not Appropriate'
)

puts 'Completed Spam Reports'
