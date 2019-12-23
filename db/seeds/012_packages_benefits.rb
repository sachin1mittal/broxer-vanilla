puts 'Starting Packages Benefits'

all_benefits = Benefit.all

Package.all.each do |package|
  benefit = all_benefits.sample

  3.times do
    allowed_values = benefit.allowed_values.split(', ')
    values = allowed_values.sample

    PackagesBenefit.create!(
      package: package,
      benefit: benefit,
      values: [values]
    )
  end
end

puts 'Completed Packages Benefits'
