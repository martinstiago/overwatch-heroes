# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'fast_jsonapi'
gem 'mongoid'
gem 'puma', '3.12.0'
gem 'rails'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-rspec'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :test do
  gem 'codecov', require: false
  gem 'database_cleaner'
  gem 'mongoid-rspec'
  gem 'rspec_junit_formatter'
  gem 'simplecov', require: false
  gem 'webmock'
end
