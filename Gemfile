# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.6.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.0'
gem 'sassc-rails'
gem 'simple-line-icons-rails'

gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

gem 'bcrypt', '~> 3.1.7'
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 3.0'
gem 'turbolinks', '~> 5'

gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'gretel'
gem 'simple_form'
gem 'slim-rails'

gem 'devise'
gem 'pundit'

gem 'active_model_serializers'
gem 'settingslogic'
gem 'tamashii-common', '>=0.1.5'
gem 'tamashii-manager', '>=0.2.7'

gem 'grape'

gem 'activerecord-import'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'capybara', '~> 2.7.0'
  gem 'selenium-webdriver'

  gem 'factory_girl_rails'
  gem 'faker'
  gem 'fuubar', require: false
  gem 'rails-controller-testing'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'simplecov', require: false

  gem 'dotenv-rails'
  gem 'rubocop', '~> 0.71.0', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'scss_lint', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Rails Console Helper
  gem 'awesome_print'
  gem 'hirb'
  gem 'pry'
  gem 'pry-rails'

  gem 'letter_opener'

  gem 'capistrano', '~> 3.6'
  gem 'capistrano-passenger'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-upload-config'

  gem 'grape-swagger'
  gem 'grape-swagger-rails'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
