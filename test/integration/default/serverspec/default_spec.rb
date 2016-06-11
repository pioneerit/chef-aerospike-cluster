require 'spec_helper'

describe 'aerospike-cluster::default' do
  describe service('aerospike') do
    it { should be_enabled }
    it { should be_running }
  end
  %w(3000 3001 3002 3003).each do |port|
    describe port(port) do
      it { should be_listening.with('tcp') }
    end
  end
end
