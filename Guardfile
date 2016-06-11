# More info at https://github.com/guard/guard#readme

# More info at https://github.com/guard/guard#readme

scope :group => :unit

if `uname` =~ /Darwin/
  require 'terminal-notifier-guard'
  notification :terminal_notifier, app_name: 'aerospike-cluster::', activate: 'com.googlecode.iTerm2' if `uname` =~ /Darwin/
end

group :unit do
  guard 'foodcritic', cookbook_paths: '.', all_on_start: false do
    watch(%r{attributes/.+\.rb$})
    watch(%r{providers/.+\.rb$})
    watch(%r{recipes/.+\.rb$})
    watch(%r{resources/.+\.rb$})
    watch('metadata.rb')
  end

  guard 'rubocop' do
    watch(%r{attributes\/.+\.rb$})
    watch(%r{providers\/.+\.rb$})
    watch(%r{recipes\/.+\.rb$})
    watch(%r{resources\/.+\.rb$})
    watch('metadata.rb')
  end

  # guard :rspec, :cmd => 'chef exec /opt/chefdk/embedded/bin/rspec --require rspec/pride --format PrideFormatter', :all_on_start => false, :notification => false do
  guard :rspec, :cmd => 'chef exec rspec --require rspec/pride --format PrideFormatter', :all_on_start => false, :notification => true do
    require 'guard/rspec/dsl'
    dsl = Guard::RSpec::Dsl.new(self)

    # Feel free to open issues for suggestions and improvements

    # RSpec files
    rspec = dsl.rspec
    watch(rspec.spec_helper) { rspec.spec_dir }
    watch(rspec.spec_support) { rspec.spec_dir }
    watch(rspec.spec_files)

    # Ruby files
    watch(%r{^libraries\/(.+)\.rb$})
    watch(%r{^spec\/(.+)_spec\.rb$})
    watch(%r{^(recipes)\/(.+)\.rb$})  { |m| "spec/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')      { 'spec' }
  end
end

# group :integration do
#   guard :kitchen do
#     watch(%r{test/.+})
#     watch(%r{^recipes/(.+)\.rb$})
#     watch(%r{^attributes/(.+)\.rb$})
#     watch(%r{^files/(.+)})
#     watch(%r{^templates/(.+)})
#     watch(%r{^providers/(.+)\.rb})
#     watch(%r{^resources/(.+)\.rb})
#   end
# end
