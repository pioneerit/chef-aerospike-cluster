# -*- coding: utf-8 -*-
require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'

::LOG_LEVEL = :fatal
::CHEFSPEC_OPTS = {
  log_level: ::LOG_LEVEL
}

def node_resources(node)
  node.set['aerospike']['install_method'] = 'package'
  node.set['aerospike']['checksum_verify'] = false
  node.set['aerospike']['version'] = '3.8.3'
  node.set['aerospike']['amc']['version'] = '3.6.8'
end

def stub_resources
  # allow(File).to receive(:exists?).with(anything).and_call_original
  # allow(File).to receive(:exists?).with('/etc/collectd.d').and_return true
  stub_command('asinfo -v statistics -l | grep cluster_size').and_return('cluster_size=2')
end

ChefSpec::Coverage.start!

RSpec.configure do |config|
  config.platform = 'centos'
  config.version = '7.2.1511'
  config.log_level = :error
  # config.expect_with(:rspec) { |c| c.syntax = :expect }
  # config.filter_run(focus: true)
  # config.run_all_when_everything_filtered = true
end

# ChefSpec::Coverage.start! { add_filter 'aerospike-cluster' }
# at_exit { ChefSpec::Coverage.report! }
