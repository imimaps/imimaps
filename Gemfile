# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails', '~> 6.1.0'

gem 'carrierwave'
gem 'caxlsx'
gem 'caxlsx_rails'
gem 'country_select'
gem 'geocoder'
gem 'nested_form'

gem 'bootstrap', '>= 4.3.1'
gem 'bootstrap-datepicker-rails'
gem 'bootstrap_form', '>= 4.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'prawn'
gem 'prawn-table'
# see https://github.com/tzinfo/tzinfo/wiki/Resolving-TZInfo::DataSourceNotFound-Errors
gem 'tzinfo-data'

gem 'activeadmin', '~> 2.9'
gem 'cancancan', '~> 3.0'
gem 'devise', '>= 4.7.1'
gem 'formtastic', '~> 3'

gem 'mini_magick'
# gem "rmagick", "~> 2.16"
gem 'paperclip', '~> 5.2'

# is this needed directly or just used by activeadmin?
# see https://github.com/kaminari/kaminari
# calls like User.page would occur
gem 'kaminari'

gem 'd3-rails'
gem 'net-ldap',
    git: 'https://github.com/imimap/ruby-net-ldap',
    tag: 'v0.16.2.deprecation.removed'

# gem 'griddler'

# Gems used only for assets and not required
# in production environments by default.
# gem 'jquery-ui-rails'
gem 'coffee-rails'
gem 'font-awesome-sass-rails'
# Use SCSS for stylesheets
gem 'sass-rails'
gem 'uglifier', '>= 1.0.3'

gem 'factory_bot_rails', '>= 5.1'

group :development do
  gem 'brakeman'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'spring'
end

# database gem
gem 'pg'

gem 'faker'

group :development, :test do
  install_if -> { ENV['IMIMAPS_ENVIRONMENT'] != 'docker' } do
    gem 'sqlite3', '~> 1.4'
  end

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rspec-mocks'
  gem 'rspec-rails'

  gem 'capybara'
  gem 'launchy'
  gem 'poltergeist'
  # gem 'rack-mini-profiler', require: false

  gem 'byebug'
  gem 'database_cleaner'
  gem 'pdf-reader' # for checking generated pdf in tests
  gem 'railroady'
  gem 'rails-controller-testing'
  gem 'simplecov', require: false
end

# To use ActiveModel has_secure_password
gem 'bcrypt', '~> 3'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

gem 'bootsnap'
gem 'listen'
