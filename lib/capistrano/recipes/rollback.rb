namespace :rollback do
  desc 'Rollback Database'
  task :database do |t|
    on roles(:db) do
      reverting_version = capture :ls, release_path.parent, '| sort -r | head -1'
      reverting_version_path = "#{release_path.parent}/#{reverting_version}"

      ## all migration files in version on which we are going to be reverted
      old_migrations = capture(:ls, '-1', File.join(release_path, 'db', 'migrate')).split("\n")

      ## all migration files in current version
      latest_migrations = capture(:ls, '-1', File.join(reverting_version_path, 'db', 'migrate')).split("\n")

      ## all migrations which are to be reverted to revert back on earlier version
      migrations_to_be_reverted = latest_migrations - old_migrations

      within(reverting_version_path) do
        migrations_to_be_reverted.each do |file|
          version = file.split('_').first
          execute :bundle, :exec, :rake, "db:migrate:down VERSION=#{version} RAILS_ENV=#{fetch(:stage)}"
        end
      end
    end
  end

  desc 'Setup Release Path'
  task :setup_release_path do
    run_locally do
      execute :echo, "#{fetch(:release_timestamp)} > #{fetch(:local_path)}/tmp/last_release_timestamp.txt"
    end
  end

  before 'deploy:finishing_rollback', 'rollback:database'
  before 'deploy:finishing_rollback', 'rollback:setup_release_path'
end
