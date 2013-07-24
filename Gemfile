source 'https://rubygems.org'

# Ruby version
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Credential management
gem 'figaro'

# Twitter
gem 'twitter'
gem 'oj'

# Slim and Twitter Bootstrap
gem 'slim-rails'
gem 'bootstrap-sass', '~> 2.3.2.0'

# Pry Console
gem 'pry'
gem 'pry-rails', group: :development

# Chartkick for Charts
gem 'chartkick'

# App server
gem 'puma'

# Decorators for clean views and models
gem 'draper'

# Twitter text extraction
gem 'twitter-text'

# Enumerize for enumerated attributes
gem 'enumerize'

# Pagination
gem 'kaminari'

group :development do
  # Debug Views
  gem 'better_errors'
  gem 'binding_of_caller'

  # LiveReload
  gem 'guard-livereload'
  gem 'rack-livereload'

  gem 'bullet'
end

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers'
  gem 'fabrication'
  gem 'database_cleaner'
  gem 'mocha'
  gem 'timecop'
  gem 'simplecov', require: false
  gem 'coveralls', require: false
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'webmock'
  gem 'vcr'
end

group :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm'
end

# Use debugger
# gem 'debugger', group: [:development, :test]
