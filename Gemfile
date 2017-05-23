source 'https://rubygems.org'

ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.0.beta1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sassc-rails'
gem 'jquery-rails'
gem 'font-awesome-rails'
gem 'simple-line-icons-rails'

gem 'uglifier', '>= 1.3.0'
gem 'webpacker', github: "rails/webpacker"

gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 3.0'
gem 'bcrypt', '~> 3.1.7'

gem 'slim-rails'
gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'simple_form'
gem 'gretel'

gem 'devise'

gem 'settingslogic'
gem 'tamashii-manager'
gem 'active_model_serializers'

gem 'grape'
gem 'rails-controller-testing'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'capybara', '~> 2.7.0'
  gem 'selenium-webdriver'

  gem 'rspec'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'simplecov', require: false
  gem 'fuubar', require: false

  gem 'dotenv-rails'
  gem 'rubocop', require: false
  gem 'scss_lint', require: false
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Rails Console Helper
  gem 'pry'
  gem 'pry-rails'
  gem 'hirb'
  gem 'awesome_print'

  gem 'letter_opener'

  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-passenger'
  gem 'capistrano-upload-config'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
