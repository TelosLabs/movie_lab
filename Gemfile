source "https://rubygems.org"

ruby "3.3.4"

gem "rails", "8.0.0.beta1"

# Database
gem "sqlite3"
gem "sqlite-vec", platform: :ruby_33
gem "activerecord-enhancedsqlite3-adapter"

# Frontend
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "tailwindcss-rails"
gem "stimulus-rails"

# Other
gem "puma"
gem "themoviedb-api"
gem "ruby-openai"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false

group :development, :test do
  gem "pry-byebug"
  gem "debug", platforms: %i[mri windows]
end

group :development do
  gem "web-console"
  gem "rack-mini-profiler"
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end
