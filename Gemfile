source "https://rubygems.org"

ruby "3.2.2"

# Manage env variables
gem 'dotenv', require: 'dotenv/load'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# User signup and authentication
gem 'devise', '~> 4.9', '>= 4.9.3'

# Background jobs
gem 'sidekiq'

# HTTP requests
gem 'httparty'

# Mock API requests
gem 'webmock'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
  gem 'rspec-rails', '~> 6.1', '>= 6.1.1'
end

