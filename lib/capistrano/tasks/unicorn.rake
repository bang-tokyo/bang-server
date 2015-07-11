# vim: ft=ruby

namespace :load do
  task :defaults do
    set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
    set :unicorn_config, -> { "#{current_path}/config/unicorn.rb" }
  end
end

namespace :unicorn do
  def start_unicorn
    within current_path do
      execute :bundle, :exec, :unicorn, "-c #{fetch(:unicorn_config)} -E #{fetch(:rails_env)} -D"
    end
  end

  def unicorn_send_signal(signal)
    if test "[ -f #{fetch(:unicorn_pid)} ]"
      pid = capture :cat, fetch(:unicorn_pid)
      execute :kill, "-s #{signal} #{pid}"
    end
  end

  desc 'Start unicorn master process.'
  task :start do
    puts "unicorn starting"
    on roles(:app), in: :sequence, wait: 5 do
      start_unicorn
    end
  end

  desc 'Stop unicorn.'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      unicorn_send_signal 'QUIT'
    end
  end

  desc 'Immediately shutdown unicorn.'
  task :shutdown do
    on roles(:app), in: :sequence, wait: 5 do
      unicorn_send_signal 'TERM'
    end
  end

  desc 'Reload unicorn.'
  task :reload do
    on roles(:app), in: :sequence, wait: 5 do
      unicorn_send_signal 'USR2'
    end
  end

  desc 'Restart unicorn.'
  task :restart do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end
end

