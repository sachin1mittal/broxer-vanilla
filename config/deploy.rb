## define roles
CAP_CONFIG['roles'].each do |role, ips|
  role role, ips
end

set :application, CAP_CONFIG['app_name']
set :branch, (CAP_CONFIG['branch'] || 'master ')
set :user, :ubuntu
set :deploy_user, :ubuntu
set :deploy_to, "#{CAP_CONFIG['paths']['server']}/#{fetch(:application)}"
set :local_path, "#{CAP_CONFIG['paths']['local']}"
set :bundle_path, -> { shared_path.join('bundle') }
set :ssh_options, { user: fetch(:user) }
set :rvm_ruby_version, '2.4.3'
set :bundle_rsync_scm, :local_git
set :repo_url, fetch(:local_path)
set :old_release, ENV['old_release']
set :bundle_rsync_rsync_options, '-az --delete --exclude=.local_repo'

append :linked_dirs, 'log', 'tmp/pids', 'tmp/sockets', 'vendor/bundle', 'bundle', 'public'
append :linked_files, 'config/settings.local.yml'
