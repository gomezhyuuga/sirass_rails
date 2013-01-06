source 'https://rubygems.org'

if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

gem 'rails', '3.2.9'
gem 'faker'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'sorcery'
gem 'simple_form'
gem 'cancan'
gem 'magic_encoding'
gem 'libv8', '~> 3.11.8'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'

  # Bootstrap
  gem 'less-rails'
  gem 'twitter-bootstrap-rails'
  gem 'bootstrap-datepicker-rails'
  # gem 'chosen-rails'
  gem 'select2-rails'
end

gem 'jquery-rails'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'spork'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'rb-fsevent', '0.9.1', :require => false
  gem 'factory_girl_rails'
end

group :development do
  gem 'annotate'
end

#group :production do
#  gem 'pg', '0.12.2'
#end