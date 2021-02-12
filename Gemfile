source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'

 #gem "recaptcha"
gem 'pg'
gem 'tinymce-rails'
gem 'tinymce-rails-langs'

gem 'tinymce-rails-imageupload', github: 'PerfectlyNormal/tinymce-rails-imageupload'
gem 'carrierwave', '~> 2.0'

gem 'octicons_helper'
gem "breadcrumbs_on_rails"

gem 'bootstrap', '~> 4.4.1'
gem 'rails_12factor'

gem 'rails-i18n'
gem 'slim-rails'
gem 'simple_form'
gem 'cocoon'
gem 'best_in_place'
gem 'russian', github: 'yaroslav/russian'
gem 'gon'
gem 'lightbox2-rails'

# decorators
gem 'draper'

# ORM
gem 'ransack'

# jquery
gem 'jquery-rails'
gem 'jquery-ui-rails'

# autorzation
gem 'devise'
gem 'authority'

gem 'state_machines-activerecord'

# Use mysql as the database for Active Record
# Use Puma as the app server
# gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

gem 'bootstrap4-kaminari-views'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
gem 'kaminari'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'


# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap'
gem 'bootstrap', '~> 4.4.1'
group :development, :test do
gem 'rspec-rails'

gem 'pry-rails'
gem 'pry-theme'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'priscilla'

  gem "better_errors"
  gem "binding_of_caller"
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
