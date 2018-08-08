puts 'Starting Skills Users'

all_skills = Skill.all

User.all.each do |user|
  5.times do
    SkillsUser.create!(
      user: user,
      skill: all_skills.sample,
      level: [:beginner, :intermediate, :expert].sample
    )
  end
end

puts 'Completed Skills Users'
