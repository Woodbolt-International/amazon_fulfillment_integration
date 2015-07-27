source 'https://rubygems.org'

gem 'sinatra'
gem 'tilt', '~> 1.4.1'
gem 'tilt-jbuilder', require: 'sinatra/jbuilder'
gem 'bugsnag', '~> 2.8'
gem 'dotenv', '~> 2.0'

gem 'endpoint_base', github: 'spree/endpoint_base'
gem 'peddler', '~> 0.17'
gem 'simple_command', '~> 0.0.9'

group :production do
  gem 'foreman'
  gem 'unicorn', '~> 4.9'
end

group :test do
  gem 'rspec', '~> 3.3'
  gem 'rack-test', '~> 0.6'
  gem 'webmock', '~> 1.21'
end
