# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

gem 'bootsnap', '~> 1.4.2', require: false
gem 'carrierwave', '~> 1.2.2'
gem 'carrierwave-base64', '~> 2.8.0'
gem 'carrierwave-i18n', '~> 0.2.0'
gem 'carrierwave-mongoid', '~> 1.3.0'
gem 'devise', '~> 4.7.1'
gem 'devise-i18n', '~> 1.9.0'
gem 'devise-i18n-views', '~> 0.3.7'
gem 'faker', '~> 2.8.1'
gem 'jbuilder', '~> 2.7'
gem 'kaminari', '~> 1.2.0'
gem 'mini_magick', '~> 4.9.4'
gem 'omniauth', '~> 1.9.0'
gem 'omniauth-facebook', '~> 5.0.0'
gem 'omniauth-twitter', '~> 1.4.0'
gem 'puma', '~> 4.3.3'
gem 'rails', '~> 6.0.2'
gem 'rails-i18n', '~> 6.0.0'
gem 'sass-rails', '~> 6'
gem 'sqlite3', '~> 1.4'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: %i[
    mri
    mingw
    x64_mingw
  ]
  gem 'factory_bot_rails', '~> 5.1.1'
  gem 'spring-commands-rspec', '~> 1.0.4'
end

group :development do
  gem 'listen', '~> 3.0.8'
  gem 'rubocop', require: false
  gem 'rubocop-rails'
  gem 'spring', '~> 2.1.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '~> 3.3.0'
end

group :test do
  gem 'capybara', '~> 2.15'
  gem 'guard', '~> 2.13.0'
  gem 'guard-minitest', '~> 2.4.4'
  gem 'guard-rspec', '~> 4.7.3', require: false
  gem 'launchy', '~> 2.4.3'
  gem 'minitest-reporters', '~> 1.1.14'
  gem 'rails-controller-testing', '~> 1.0.4'
  gem 'rspec-rails', '~> 3.9.0'
  gem 'selenium-webdriver', '~> 3.142.6'
  gem 'webdrivers', '~> 4.1.3'
end

group :production do
  gem 'fog', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[
  mingw
  mswin
  x64_mingw
  jruby
]
