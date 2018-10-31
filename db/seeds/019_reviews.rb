puts 'Starting Reviews'

all_users = User.all
all_jobs_and_users = [Job.all, all_users].flatten

2000.times do
  reviewable = all_jobs_and_users.sample
  reviewer = all_users.sample

  parent_review1 = Review.create!(
    reviewable: reviewable,
    reviewer: reviewer,
    act: :seller_communication,
    comment: Faker::Lorem.sentence,
    parent_id: nil,
    rating: (1..5).step(0.1).to_a.sample.round(1)
  )

  parent_review2 = Review.create!(
    reviewable: reviewable,
    reviewer: reviewer,
    act: :service_as_described,
    comment: Faker::Lorem.sentence,
    parent_id: nil,
    rating: (1..5).step(0.1).to_a.sample.round(1)
  )

  parent_review3 = Review.create!(
    reviewable: reviewable,
    reviewer: reviewer,
    act: :would_recommend,
    comment: Faker::Lorem.sentence,
    parent_id: nil,
    rating: (1..5).step(0.1).to_a.sample.round(1)
  )

  3.times do
    Review.create!(
      reviewable: reviewable,
      reviewer: reviewer,
      act: :seller_communication,
      comment: Faker::Lorem.sentence,
      parent_id: parent_review1.id,
      rating: (1..5).step(0.1).to_a.sample.round(1)
    )
  end

  3.times do
    Review.create!(
      reviewable: reviewable,
      reviewer: reviewer,
      act: :service_as_described,
      comment: Faker::Lorem.sentence,
      parent_id: parent_review2.id,
      rating: (1..5).step(0.1).to_a.sample.round(1)
    )
  end

  3.times do
    Review.create!(
      reviewable: reviewable,
      reviewer: reviewer,
      act: :would_recommend,
      comment: Faker::Lorem.sentence,
      parent_id: parent_review3.id,
      rating: (1..5).step(0.1).to_a.sample.round(1)
    )
  end
end

puts 'Completed Reviews'
