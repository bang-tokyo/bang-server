set :rails_env, :staging
set :migration_role, :migration
set :branch, "master"

server 'bang-gw01', user:"bang", roles: %w{web app migration batch}
