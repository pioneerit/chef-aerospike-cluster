#
# Cookbook Name:: aerospike-cluster
# Spec:: default
#

require 'spec_helper'

describe 'aerospike-cluster::default' do
  before { stub_resources }
  context 'Package installation, on CentOS >= 7 platform' do
    # let(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }
    let(:chef_run) do
      ChefSpec::ServerRunner.new do |node|
        node_resources(node)
      end.converge(described_recipe)
    end

    %w( aerospike-cluster::attributes
        aerospike-cluster::install
        aerospike-cluster::config).each do |recipe|
      it 'include recipes' do
        expect(chef_run).to include_recipe(recipe)
      end
    end

    it 'Aerospike user' do
      expect(chef_run).to create_user('aerospike')
      expect(chef_run).to create_group('aerospike')
    end

    %w( /etc/aerospike /var/log/aerospike /opt/aerospike /opt/aerospike/data /opt/aerospike/smd /opt/aerospike/usr/udf/lua /opt/aerospike/sys/udf/lua /usr/local/aerospike ).each do |dir|
      it "Create directories #{dir}" do
        expect(chef_run).to create_directory(dir)
      end
    end

    it 'Aerospike services' do
      expect(chef_run).to enable_service('aerospike')
      expect(chef_run).to start_service('aerospike')
    end

    it 'AMC services' do
      expect(chef_run).to enable_service('amc')
      expect(chef_run).to start_service('amc')
    end

    %w( /usr/local/aerospike/aerospike-server-community-3.8.3-el7/aerospike-server-community-3.8.3-1.el7.x86_64.rpm
        /usr/local/aerospike/aerospike-server-community-3.8.3-el7/aerospike-tools-3.8.3-1.el7.x86_64.rpm
        aerospike-amc-community-3.6.8-el5 ).each do |package|
      it "Install #{package}" do
        expect(chef_run).to install_package(package)
      end
    end

    %w( /usr/local/aerospike/aerospike-amc-community-3.6.8-el5.x86_64.rpm /usr/local/aerospike/aerospike-server-community-3.8.3-el7.tgz ).each do |file|
      it "Download remote file #{file}" do
        expect(chef_run).to create_remote_file(file)
      end
    end

    %w( /etc/amc/config/gunicorn_config.py /etc/amc/config/amc.cfg /etc/aerospike/aerospike.conf ).each do |template_file|
      it "Create template - #{template_file}" do
        expect(chef_run).to create_template(template_file)
      end
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end
  end
end
