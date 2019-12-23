puts 'Starting Spam Reports'

SpamReport.create!(
  reporter: User.first,
  reportable: Job.last,
  comment: 'Not Appropriate',
  status: SpamReport.statuses.keys.sample
)

puts 'Completed Spam Reports'
