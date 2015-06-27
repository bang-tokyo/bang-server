source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'nokogiri', '1.6.6.2'
gem 'rails', '4.2.1'
# Use mysql as the database for Active Record
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


# For Application
gem 'rb-readline', '~> 0.4.2'
gem 'annotate'
gem 'activerecord-mysql-awesome'
gem 'symmetric-encryption'
gem 'weak_parameters'

# For Application Test
group :development, :test do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'factory_girl_rails'
  gem 'spring'
  gem 'byebug'
  gem 'web-console', '~> 2.0'

  gem 'capistrano', '~> 3.4.0', :require => false
  gem 'capistrano-rbenv', :require => false
  gem 'capistrano-rails', :require => false
  gem 'capistrano-bundler', :require => false
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'quiet_assets'
end

group :production, :staging do
  gem 'unicorn'
end

gem 'aws-sdk'
gem 'whenever'
gem 'libv8', '3.16.14.3'
gem 'execjs'
gem 'therubyracer'
