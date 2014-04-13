source 'https://rubygems.org'
source 'https://rails-assets.org'

gem 'rails', '4.1.0'
gem 'pg'
gem 'annotate', github: 'ivanyv/annotate_models'

gem 'slim-rails', github: 'slim-template/slim-rails'
gem 'less-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'less-rails-bootstrap'
gem 'font-awesome-rails'
gem 'non-stupid-digest-assets'
gem 'therubyracer', platforms: :ruby

gem 'simple_form'
gem 'nested_form'
gem 'kaminari'
gem 'pundit'
gem 'draper'
gem 'reform', github: 'apotonick/reform'
gem 'paperclip'

gem 'bcrypt-ruby', '~> 3.1.2'
gem 'dotenv-rails'

group :development do
  gem 'mina'
  gem 'mina-scp', require: false
  gem 'zeus', '0.13.4.pre2'
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-test'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rails_db_info'
  gem 'letter_opener'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'letters', require: false
  gem 'debugging'
  gem 'capybara'
end

group :test do
  # Including these two shouldn't be necessary,
  # but living on the edge causes some odd behaviors otherwise.
  gem 'minitest', require: false
  gem 'test-unit'
  gem 'flexmock'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
end
