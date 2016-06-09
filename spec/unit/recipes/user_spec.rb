#
# Cookbook Name:: aerospike-cluster
# Spec:: user
#

require 'spec_helper'

describe 'aerospike-cluster::user' do
  subject { ChefSpec::ServerRunner.new.converge(described_recipe) }

  it 'creates user aerospike' do
    expect(subject).to create_user('aerospike').with(
      :home => nil,
      :shell => '/bin/false'
    )
  end

  it 'creates group aerospike' do
    expect(subject).to create_group('aerospike')
  end
end
