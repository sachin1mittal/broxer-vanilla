puts 'Starting Users'

selected_countries = [
  'Pakistan', 'Netherlands', 'Saudi Arabia', 'Switzerland', 'China',
  'India', 'Bangladesh', 'United States of America', 'New Zealand', 'Norway'
]

Country.where(name: selected_countries).each do |country|
  10.times do
    u_name = Faker::Name.name
    @user = User.create!(
      name: u_name,
      email: Faker::Internet.email,
      password: '123456',
      confirm_password: '123456',
      country: country,
      provider: [:google_oauth2, :facebook, :twitter, :linkedin, :email].sample,
      token_expires_at: 60.days.from_now,
      authentication_token: SecureRandom.hex(10),
      uid: SecureRandom.hex(5),
      level: [:beginner, :intermediate, :expert].sample,
      gplus_profile: 'https://gplus.com/' + u_name,
      facebook_profile: 'https://facebook.com/' + u_name,
      twitter_profile: 'https://twitter.com/' + u_name,
      linkedin_profile: 'https://linkedin.com/' + u_name,
      description: Faker::Lorem.paragraph,
      phone_number: Faker::PhoneNumber.phone_number,
      profile_pic: File.open('/Users/sachinmittal/Desktop/a.jpg', 'rb'),
      status: [:verified, :unverified].sample,
      availability_type: [:part, :full].sample,
      expected_income_per_month: (250..1000).to_a.sample,
      languages: [Faker::ProgrammingLanguage.name],
      educations: [{
        university: Faker::Educator.university,
        title: Faker::Educator.course,
        degree: Faker::Job.education_level,
        year: (1990..2015).to_a.sample
      }],
      certificates: [{
        name: Faker::Educator.course,
        provider: Faker::Educator.university,
        year: (1990..2015).to_a.sample
      }]
    )
  end
end

puts 'Completed Users'
