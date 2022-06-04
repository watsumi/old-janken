source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails', '~> 7.0.2', '>= 7.0.2.4'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'importmap-rails'
gem 'jsbundling-rails'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'redis', '~> 4.0'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails', '~> 1.0.0'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'active_hash', '~> 2.3.0'
gem 'haml-rails', '~> 2.0'
gem 'meta-tags'
gem 'rambulance'
gem 'seed-fu'

group :development, :test do
  gem 'bullet'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman' # 脆弱性診断 brakeman で実行
  gem 'rails_best_practices', require: false # bundle exec rails_best_practices で実行
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'web-console'
end
