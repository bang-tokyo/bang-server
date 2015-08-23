# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'bang-server'
set :repo_url, 'https://github.com/bang-tokyo/bang-server'
set :deploy_to, "/var/www/#{fetch(:application)}"
set :keep_releases, 10
set :rbenv_type, :system
set :rbenv_ruby, '2.1.5'
set :rbenv_custom_path, '/usr/local/rbenv'
set :whenever_roles, :batch
set :whenever_identifier, ->{"#{fetch(:application)}_#{fetch(:stage)}"}
set :linked_dirs, fetch(:linked_dirs, []) + %w{log tmp/pids tmp/cache tmp/sockets}

set :default_env, {
      path: %w(
    /usr/local/rbenv/shims
    $PATH
  ).join(':')}

set :overridable_attributes, [
      :branch
    ]

namespace :deploy do
  task :start do
    invoke 'unicorn:start'
  end

  task :stop do
    invoke 'unicorn:stop'
  end

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:reload'
  end
  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 3 do
    end
  end

  #after :restart, :clear_cache do
  #  on roles(:web), in: :groups, limit: 3, wait: 10 do
  #    # Here we can do anything such as:
  #    # within release_path do
  #    #   execute :rake, 'cache:clear'
  #    # end
  #  end
  #end
end
