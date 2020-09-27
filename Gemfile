source 'https://rubygems.org'

ruby '2.7.1'

gem 'rails',                   '6.0.3.3'
gem "actionview"
gem 'bcrypt'
gem 'faker'
gem 'carrierwave'
gem "mini_magick"
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem "bootstrap-sass"
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'bootsnap', require: false
gem "nokogiri"
gem 'omniauth'
gem 'omniauth-twitter'
gem 'dotenv-rails'
gem 'activerecord-import'
gem 'whenever'
gem 'font-awesome-sass'
gem "omniauth-rails_csrf_protection"
gem "sidekiq"

group :development, :test do
  gem 'sqlite3'
  gem 'byebug',  '9.0.6', platform: :mri
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'rails-controller-testing'
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'guard'
  gem 'guard-minitest'
end

group :production, :test do
  gem 'pg'
end

group :production do
  gem 'fog'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
