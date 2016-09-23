source 'https://rubygems.org'

ruby '2.2.4'

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg', '~> 0.18.4'
gem 'puma', '~> 3.0'

gem 'sinatra', require: false
gem 'sidekiq'
gem 'react-rails'

gem 'devise'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-google-oauth2'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
# gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
# gem 'redis', '~> 3.0'
# gem 'bcrypt', '~> 3.1.7'
gem 'will_paginate', '~> 3.1.0'

gem 'elasticsearch-model'
gem 'elasticsearch-rails'

gem 'bootstrap-sass', '~> 3.3.6'
gem 'font-awesome-sass', '~> 4.6.2'
gem 'friendly_id', '~> 5.1.0'

gem 'carrierwave', '>= 1.0.0.beta', '< 2.0'
gem 'mini_magick', '3.8.0'
gem 'fog',  '1.36.0'
gem 'net-ssh'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'aws-sdk', '~> 2'

group :production do
  gem 'rails_12factor', '0.0.2'
  gem 'bonsai-elasticsearch-rails'
end

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
