set_default :sidekiq_log_file, -> { "#{current_path}/log/sidekiq.log" }
set_default :sidekiq_pids, -> { "#{current_path}/tmp/pids/sidekiq" }
set_default :sidekiq_config, -> { "#{current_path}/config/sidekiq" }

namespace :sidekiq do
  desc 'Manage Sidekiq'

  def sidekiq_configs
    command = "if [ -d '#{fetch(:sidekiq_config)}' ]; then ls #{fetch(:sidekiq_config)}; fi"
    capture(command).split("\n")
  end

  def sidekiq_pids
    command = "if [ -d '#{fetch(:sidekiq_pids)}' ]; then ls #{fetch(:sidekiq_pids)}; fi"
    capture(command).split("\n")
  end

  def get_sidekiq_pid
    command = "ps aux | grep sidekiq | grep #{fetch(:application)} | grep -v grep | awk '{print $2}'"
    capture(command) if test(command)
  end

  def sidekiq_running?
    not get_sidekiq_pid.to_s.empty?
  end

  task :test do
    on roles(:job) do
      within current_path do
        puts get_sidekiq_pid
      end
    end
  end

  task :start do
    on roles(:job) do
      within current_path do
        base_command = [:bundle, :exec, :sidekiq, '-d', '-e', fetch(:stage), '-L', fetch(:sidekiq_log_file)]
        execute :mkdir, '-p', fetch(:sidekiq_pids)
        sidekiq_configs.each do |config|
          puts config
          worker_name = config.match(/(\w+)\.yml/)[1]
          pid_file = "#{fetch(:sidekiq_pids)}/#{worker_name}.pid"
          config_file = "#{fetch(:sidekiq_config)}/#{config}"
          command = base_command + ['-P', pid_file, '-C', config_file]
          execute(*command)
        end
      end
    end
  end

  task :stop do
    on roles(:job) do
      within current_path do
        sidekiq_pids.each do |pid|
          pid_file = "#{fetch(:sidekiq_pids)}/#{pid}"
          execute :bundle, :exec, :sidekiqctl, :stop, pid_file, 5
        end

        execute :rm, '-rf', fetch(:sidekiq_pids)
      end
    end
  end

  task :restart do
    on roles(:job) do
      within current_path do
        if sidekiq_running?
          invoke('sidekiq:stop')
        end
        invoke('sidekiq:start')
      end
    end
  end
  after 'deploy:log_revision', 'sidekiq:restart'
end
