puts 'Starting Packages'

Job.all.each do |job|

  [:basic, :standard, :premium].each do |p_type|
    Package.create!(
      job: job,
      title: Faker::Lorem.word,
      package_type: p_type,
      description: Faker::Lorem.sentence,
      delivery_time: (2..100).to_a.sample,
      revisions: (0..5).to_a.sample,
      price: (5..1000).to_a.sample,
      extras: [{
        title: Faker::Lorem.word,
        description: Faker::Lorem.sentence,
        delivery_time: (2..100).to_a.sample,
        price: (5..1000).to_a.sample
      }]
    )
  end

end

puts 'Completed Packages'
