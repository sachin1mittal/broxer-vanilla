desc "This task execute all command that is required for successful deployment"
task :deploy do
  puts "Deployment task initiated"

  # Unlock all resources
  # Rake::Task['synchronize:unlock_all'].invoke

  puts "Deployment task completed"
end
