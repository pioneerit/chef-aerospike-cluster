#
# Cookbook Name:: aerospike-cluster
# Spec:: monitoring
#

require 'spec_helper'

describe 'aerospike-cluster::monitoring' do
  # before { stub_resources }
  context 'Package installation, on CentOS >= 7 platform' do
    # let(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }
    let(:chef_run) do
      ChefSpec::ServerRunner.new do |node|
        node_resources(node)
        node.set['aerospike']['monitoring'] = ['collectd']
      end.converge(described_recipe)
    end

    %w(collectd).each do |recipe|
      it "include recipes #{recipe}" do
        expect(chef_run).to include_recipe("aerospike-cluster::monitoring_#{recipe}")
      end
    end

    %w(git PyYAML).each do |p|
      it "Install #{p}" do
        expect(chef_run).to install_package(p)
      end
    end
    it 'Expect export from github' do
      expect(chef_run).to export_git('/opt/aerospike-collectd').with(repository: 'https://github.com/aerospike/aerospike-collectd.git', reference: 'master')
    end
    it 'Rolls out template and config for aerospike metrics sending' do
      expect(chef_run).to render_file('/etc/collectd.d/aerospike.conf').with_content(/^# This file is managed by Chef(.+)$/)
    end
    it 'converges successfully' do
      chef_run # This should not raise an error
    end
  end
end
