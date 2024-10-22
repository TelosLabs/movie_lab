source "https://rubygems.org"

ruby "3.3.4"

gem "rails", "8.0.0.beta1"

# Database
gem "sqlite3"
gem "activerecord-enhancedsqlite3-adapter"

# Vector search
gem "sqlite-vec", platform: :ruby_33
gem "neighbor"

# Server
gem "puma"

# APIs
gem "themoviedb-api"
gem "ruby-openai"

# Frontend
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "tailwindcss-rails"
gem "stimulus-rails"

# Vector search
gem "sqlite-vec", platform: :ruby_33
gem "neighbor"

# Other
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false

group :development, :test do
  gem "dotenv"
  gem "pry-byebug"
  gem "debug", platforms: %i[mri windows]
end

group :development do
  gem "annotate"
  gem "web-console"
  gem "rack-mini-profiler"
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end
