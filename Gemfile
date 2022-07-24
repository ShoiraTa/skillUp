source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "rails", "~> 7.0.3"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# added gems
gem "bootsnap", require: false
gem "haml-rails", "~> 2.0"
gem 'simple_form'
gem "image_processing", "~> 1.2"
gem 'faker'
gem 'devise'
gem 'friendly_id', '~> 5.4.0'
gem 'ransack'
gem 'public_activity'
gem "rolify"
gem "pundit", "~> 2.2"
gem 'exception_notification'
gem 'pagy', '~> 5.10'
gem "chartkick"
gem "groupdate"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end


