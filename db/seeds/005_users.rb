puts 'Starting Users'

selected_countries = [
  'Pakistan', 'Netherlands', 'Saudi Arabia', 'Switzerland', 'China',
  'India', 'Bangladesh', 'United States of America', 'New Zealand', 'Norway'
]

roles = Role.all

Country.where(name: selected_countries).each do |country|
  10.times do
    u_name = Faker::Name.name
    @user = User.create!(
      name: u_name,
      email: Faker::Internet.email,
      encrypted_password: Digest::SHA1.hexdigest('123456'),
      provider: [:google, :facebook, :twitter, :linkedin, :email].sample,
      pre_token: '1234',
      gplus_profile: 'https://gplus.com/' + u_name,
      facebook_profile: 'https://facebook.com/' + u_name,
      twitter_profile: 'https://twitter.com/' + u_name,
      linkedin_profile: 'https://linkedin.com/' + u_name,
      country: country,
      username: u_name.parameterize.underscore,
      description: Faker::Lorem.paragraph,
      profile_pic: File.open('/Users/sachin/Desktop/a.jpg', 'rb'),
      status: [:verified, :unverified].sample,
      availability_type: [:part, :full].sample,
      wallet_balance: (1..5).step(0.1).to_a.sample.round(2),
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
    @user.add_role(roles.sample)
  end
end

puts 'Completed Users'
