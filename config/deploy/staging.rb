set :rails_env, :staging
set :migration_role, :migration
set :branch, "develop"

server 'bang-gw01', user:"bang", roles: %w{web app migration batch}
