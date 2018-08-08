puts 'Starting Countries'

ISO3166::Country.all.each do |country|
  Country.create(
    name: country.name,
    phone_code: country.country_code
  )
end

puts 'Completed Countries'
