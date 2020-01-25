# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'jbuilder', '~> 2.7'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.1'
gem 'rails-i18n'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: %i[
    mri
    mingw
    x64_mingw
  ]
  gem 'spring-commands-rspec'
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'guard'
  gem 'guard-minitest'
  gem 'guard-rspec', require: false
  gem 'launchy'
  gem 'minitest-reporters'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.9.0'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
  gem 'pg', '>= 1.1.4'
end

gem 'tzinfo-data', platforms: %i[
  mingw
  mswin
  x64_mingw
  jruby
]
