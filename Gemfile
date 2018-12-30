source 'https://rubygems.org'


gem 'bootstrap-sass', '~> 3.3.7'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.11'
gem 'faker', '~> 1.6.3'
gem 'rails_admin', '~> 0.8.1'
gem 'will_paginate'
gem 'bootstrap-will_paginate'

# Use Puma as the app server
gem 'puma', '~> 3.0'
# ensure applications get the most out of the Heroku platform
gem 'rails_12factor'
# 需要使用正确的ruby版本
ruby '2.5.1'
#simple form
gem 'simple_form', '~> 4.0'

# for download
gem 'paperclip', '~> 6.1'

# for seed
gem 'faker', '~> 1.6.3'

# for chat room
gem 'faye'
gem 'thin', require: false
gem 'responders', '~> 2.0'
gem 'render_sync'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.2'
# Use sqlite3 as the database for Active Record
#在开发和测试阶段用，产品阶段用pg
#gem 'sqlite3'
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

gem 'json'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
group :production do
  gem 'pg', '~> 0.18.4'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

