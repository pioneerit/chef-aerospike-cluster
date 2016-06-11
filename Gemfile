source 'https://rubygems.org'

group :development do
  gem 'rake'
  gem 'berkshelf'
  gem 'foodcritic'
  gem 'rubocop'
  gem 'guard'
  gem 'guard-rubocop'
  gem 'guard-foodcritic'
  gem 'guard-kitchen'
  gem 'guard-rspec'
  if RbConfig::CONFIG['target_os'] =~ /darwin/i
    gem 'terminal-notifier-guard'
  end
end

group :test do
  gem 'chefspec'
  gem 'rspec-pride'
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'kitchen-docker', '~> 2.4.0'
  if ENV['CI'] == 'true'
    gem 'chef', '~> 12.8.1'
    gem 'listen', '3.0.7'
  end
end
