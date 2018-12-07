require 'byebug'

if ENV['VERSION'].present?
  puts 'Starting Main Seeds File'
  if ENV['VERSION'] == 'all'
    Dir["#{Rails.root}/db/seeds/*"].sort.each do |seed_file|
      load(seed_file)
    end
  elsif ENV['VERSION'].to_i > 0 && ENV['VERSION'].include?('only')
    Dir["#{Rails.root}/db/seeds/*"].each do |seed_file|
      if seed_file.split('/').last.split('_').first.to_i == ENV['VERSION'].to_i
        load(seed_file)
      end
    end
  elsif ENV['VERSION'].to_i > 0
    Dir["#{Rails.root}/db/seeds/*"].sort.each do |seed_file|
      if seed_file.split('/').last.split('_').first.to_i >= ENV['VERSION'].to_i
        load(seed_file)
      end
    end
  end
  puts 'Completed Main Seeds File'
else
  puts "run `rake db:seed with VERSION`\n"
  puts "For example : `rake db:seed VERSION=111`\n"
  puts 'Any seed files whose version is less than given version will not be seeded.'
  puts 'If you want to add all seed files than run `rake db:seed VERSION=all`.'
  puts 'To seed single file, run `rake db:seed VERSION=111only`.'
end
